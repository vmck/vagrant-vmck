module VagrantPlugins
  module Vmck
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :vmck_url
      attr_accessor :private_key_path
      attr_accessor :memory
      attr_accessor :cpus

      def initialize
        @vmck_url = UNSET_VALUE
        @private_key_path = UNSET_VALUE
        @memory = UNSET_VALUE
        @cpus = UNSET_VALUE
      end

      def finalize!
        @vmck_url = nil if @vmck_url == UNSET_VALUE
        @private_key_path = nil if @private_key_path == UNSET_VALUE
        @memory = 512 if @memory == UNSET_VALUE
        @cpus = 1 if @cpus == UNSET_VALUE
      end

    end
  end
end
