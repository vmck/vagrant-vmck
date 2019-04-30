module VagrantPlugins
  module Vmck
    class Plugin < Vagrant.plugin('2')
      name "Vmck"

      config :vmck, :provider do
        require_relative 'config'
        Config
      end

      provider :vmck  do
        require_relative 'provider'
        Provider
      end
    end

  end
end
