require 'log4r'
require 'vagrant-vmck/action'

module VagrantPlugins
  module Vmck
    class Provider < Vagrant.plugin('2', :provider)

      def initialize(machine)
        @machine = machine
        @logger = Log4r::Logger.new("vagrant_vmck::provider")
      end

      def action(name)
        return Action.send(name) if Action.respond_to?(name)
        nil
      end

      def ssh_info
        env = @machine.action('read_job', lock: false)
        job = env[:vmck_job]

        return nil unless job['ready_for_ssh']

        return {
          :host => job['ssh']['host'],
          :port => job['ssh']['port'],
          :username => job['ssh']['username'],
          :private_key_path => @machine.provider_config.private_key_path,
        }
      end

      def state
        env = @machine.action('read_job', lock: false)
        state = env[:vmck_job]['state']
        long = short = state.to_s
        Vagrant::MachineState.new(state, short, long)
      end

    end
  end
end
