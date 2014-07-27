require 'dnssd'

module WhippedCream
  #Allows discovery of other whipped-cream servers on the LAN
  class Discoverer

    def register_server(name, service, domain, port)
      DNSSD.register(name, service, domain, port) do |reply|
        raise "Unable to register web server" unless reply.flags.add?
      end
    end

    def list
      discover.each do |host|
        puts "#{host[:address]}:#{host[:port]}\t#{host[:name]}"
      end
    end

    def discover
      browse_services('_whipped-cream._tcp.').map do |service|
        resolve_service(service)
      end
    end

  private

    def browse_services(service_type)
      services = []

      begin
        timeout 5 do
          DNSSD::Service.new.browse(service_type) do |reply|
            services << reply if reply.flags.add?
            break unless reply.flags.more_coming?
          end
        end
      rescue Timeout::Error
        log "ERROR: #browse_services took more than 5 seconds."
      end

      services
    end

    def resolve_service(service)
      host = {}

      begin
        timeout 5 do
          DNSSD::Service.new.resolve(service) do |reply|
            address = get_ipv4_address(reply)

            host[:name]    = "#{reply.name}"
            host[:address] = "#{address}"
            host[:port]    = "#{reply.port}"
            break unless reply.flags.more_coming?
          end
        end
      rescue Timeout::Error
        log "ERROR: #resolve_service took more than 5 seconds."
      end

      host
    end

    def get_ipv4_address(reply)
      address = nil

      begin
        timeout 5 do
          DNSSD::Service.new.getaddrinfo(reply.target, 1) do |addrinfo|
            address = addrinfo.address
            break unless addrinfo.flags.more_coming?
          end
        end
      rescue Timeout::Error
        log "ERROR: #get_ipv4_address took more than 5 seconds."
      end

      address
    end
  end
end
