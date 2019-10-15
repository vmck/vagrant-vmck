module VagrantPlugins
  module Vmck
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :vmck_url
      attr_accessor :private_key_path
      attr_accessor :memory
      attr_accessor :cpus
      attr_accessor :image_path
      attr_accessor :storage
      attr_accessor :name
      attr_accessor :restrict_network

      def initialize
        @vmck_url = UNSET_VALUE
        @private_key_path = UNSET_VALUE
        @memory = UNSET_VALUE
        @cpus = UNSET_VALUE
        @image_path = UNSET_VALUE
        @storage = UNSET_VALUE
        @name = UNSET_VALUE
        @restrict_network = UNSET_VALUE
      end

      def finalize!
        @vmck_url = nil if @vmck_url == UNSET_VALUE
        @private_key_path = nil if @private_key_path == UNSET_VALUE
        @memory = 512 if @memory == UNSET_VALUE
        @cpus = 1 if @cpus == UNSET_VALUE
        @image_path = 'imgbuild-master.qcow2.tar.gz' if @image_path == UNSET_VALUE
        @storage = nil if @storage == UNSET_VALUE
        @name = 'default' if @name == UNSET_VALUE
        @restrict_network = false if @restrict_network == UNSET_VALUE
      end

    end
  end
end
