require 'log4r'
require 'vagrant-vmck/client'

module VagrantPlugins
  module Vmck
    module Action
      class ConnectVmck

        def initialize(app, env)
          @app = app
          @logger = Log4r::Logger.new("vagrant_vmck::action::connect")
        end

        def call(env)
          url = env[:machine].provider_config.vmck_url
          abort("`vmck_url` is not set.") unless url
          env[:vmck] = Vmck::Client.new(url)
          @app.call(env)
        end

      end
    end
  end
end
