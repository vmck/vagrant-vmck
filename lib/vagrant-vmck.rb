require 'vagrant-vmck/version'
require 'vagrant-vmck/plugin'

module VagrantPlugins
  module Vmck

    lib_path = Pathname.new(File.expand_path('../vagrant-vmck', __FILE__))

    autoload :Action, lib_path.join('action')

    def self.source_root
      @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end

  end
end
