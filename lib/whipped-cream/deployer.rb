require 'net/scp'
require 'net/ssh'

module WhippedCream
  # Prepares a Pi for deployment, and deploys a plugin
  class Deployer
    attr_reader :plugin_filename, :pi_address

    def initialize(plugin_filename, pi_address)
      @plugin_filename = plugin_filename
      @pi_address = pi_address
    end

    def deploy
      bootstrap
      copy_plugin
      kill_all_plugins
      run_plugin
    end

    def scp
      @scp ||= Net::SCP.start(*connection_arguments)
    end

    def ssh
      @ssh ||= Net::SSH.start(*connection_arguments)
    end

    private

    def connection_arguments
      [pi_address, 'pi', { password: 'raspberry' }]
    end

    def bootstrap
      ssh_exec <<-SCRIPT
        dpkg --status ruby1.9.3 > /dev/null ||
          (time sudo apt-get update &&
           time sudo apt-get install ruby1.9.3 -y)

        which whipped-cream ||
          time sudo gem install whipped-cream --no-ri --no-rdoc --pre

        mkdir -p ~/whipped-cream/
      SCRIPT
    end

    def copy_plugin
      scp_copy plugin_filename, "whipped-cream/#{plugin_filename}"
    end

    def kill_all_plugins
      ssh_exec 'sudo pkill -9 -f whipped-cream'
    end

    def run_plugin
      ssh_exec <<-SCRIPT
        cd ~/whipped-cream
        sudo whipped-cream start #{plugin_filename} --daemonize
      SCRIPT
    end

    def scp_copy(local, remote)
      puts "Copying #{local} to pi@#{pi_address}:#{remote}"
      scp.upload! local, remote
    end

    def ssh_exec(command)
      command = command.prepend("set -ex\n")

      ssh.open_channel do |channel|
        channel.exec command do |process|
          process.on_data do |_, data|
            $stdout.print data
          end

          process.on_extended_data do |_, _, data|
            $stderr.print data
          end
        end
      end.wait
    end
  end
end
