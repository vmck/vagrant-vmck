require 'log4r'

module VagrantPlugins
  module Vmck
    module Action
      class Destroy

        def initialize(app, env)
          @app = app
          @logger = Log4r::Logger.new("vagrant_vmck::action::start_instance")
        end

        def call(env)
          id = env[:machine].id
          env[:ui].info("Vmck destroying job #{id} ...")

          env[:vmck].stop(id)
          env[:machine].id = nil
          env[:ui].info("Vmck job #{id} destroyed successfully")

          @app.call(env)
        end

      end
    end
  end
end
