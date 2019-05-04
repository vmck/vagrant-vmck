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
          env[:vmck_job] = read_job(env[:vmck], env[:machine].id)
          @app.call(env)
        end

        def read_job(client, job_id)
          return {'state': nil} if job_id.nil?
          job_state = client.get(job_id)
          job_state['ready_for_ssh'] = !! job_state['ssh']
          return job_state
        end

      end
    end
  end
end
