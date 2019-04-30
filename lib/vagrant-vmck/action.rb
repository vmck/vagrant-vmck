require 'vagrant-vmck/action/connect_vmck'
require 'vagrant-vmck/action/read_job'
require 'vagrant-vmck/action/create'
require 'vagrant-vmck/action/destroy'

module VagrantPlugins
  module Vmck
    module Action
      include Vagrant::Action::Builtin

      def self.read_job
        return Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use ConnectVmck
          builder.use ReadJob
        end
      end

      def self.up
        return Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use ConnectVmck
          builder.use Create
        end
      end

      def self.ssh
        return Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use ConnectVmck
          builder.use SSHExec
        end
      end

      def self.destroy
        return Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use ConnectVmck
          builder.use Destroy
        end
      end

    end
  end
end
