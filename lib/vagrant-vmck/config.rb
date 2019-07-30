module VagrantPlugins
  module Vmck
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :vmck_url
      attr_accessor :private_key_path
      attr_accessor :memory
      attr_accessor :cpus
      attr_accessor :image_path
      attr_accessor :usbstick

      def initialize
        @vmck_url = UNSET_VALUE
        @private_key_path = UNSET_VALUE
        @memory = UNSET_VALUE
        @cpus = UNSET_VALUE
        @image_path = UNSET_VALUE
        @usbstick = UNSET_VALUE
      end

      def finalize!
        @vmck_url = nil if @vmck_url == UNSET_VALUE
        @private_key_path = nil if @private_key_path == UNSET_VALUE
        @memory = 512 if @memory == UNSET_VALUE
        @cpus = 1 if @cpus == UNSET_VALUE
        @image_path = 'imgbuild-master.qcow2.tar.gz' if @image_path == UNSET_VALUE
        @usbstick = nil if @usbstick == UNSET_VALUE
      end

    end
  end
end
