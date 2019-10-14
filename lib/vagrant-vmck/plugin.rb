module VagrantPlugins
  module Vmck
    class Plugin < Vagrant.plugin('2')
      name "Vmck"

      config :vmck, :provider do
        require_relative 'config'
        Config
      end

      provider :vmck  do
        setup_logging

        require_relative 'provider'
        Provider
      end

      def self.setup_logging
        require "log4r"

        level = nil
        begin
          level = Log4r.const_get(ENV["VAGRANT_LOG"].upcase)
        rescue NameError
          level = nil
        end

        level = nil if !level.is_a?(Integer)

        if level
          logger = Log4r::Logger.new("vagrant_vmck")
          logger.outputters = Log4r::Outputter.stderr
          logger.level = level
          logger = nil
        end
      end

    end
  end
end
