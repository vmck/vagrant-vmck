require 'log4r'

module VagrantPlugins
  module Vmck
    module Action
      class ReadJob

        def initialize(app, env)
          @app = app
          @logger = Log4r::Logger.new("vagrant_vmck::action::start_instance")
        end

        def call(env)
          env[:vmck_job] = read_job(env[:vmck], env[:machine])
          @app.call(env)
        end

        def read_job(client, machine)
          return {'state': nil} if machine.id.nil?
          return client.get(machine.id)
        end

      end
    end
  end
end
