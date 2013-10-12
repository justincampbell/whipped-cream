require 'sinatra'

module WhippedCream
  # A Sinatra application skeleton that is used to build up the web server
  # for this plugin.
  class Web < Sinatra::Application
    get '/' do
      erb :index
    end

    private

    def controls
      runner.plugin.controls
    end

    def runner
      Runner.instance
    end

    def title
      runner.name
    end
  end
end
