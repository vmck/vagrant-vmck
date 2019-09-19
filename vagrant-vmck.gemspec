$:.unshift File.expand_path("../lib", __FILE__)
require "vagrant-vmck/version"

Gem::Specification.new do |spec|
  spec.name          = "vagrant-vmck"
  spec.version       = VagrantPlugins::Vmck::VERSION
  spec.authors       = ["Alex Morega"]
  spec.email         = ["alex@grep.ro"]
  spec.summary       = "Vagrant provider plugin for Vmck."
  spec.description   = "Enables Vagrant to use Vmck jobs."
  spec.homepage      = "https://github.com/mgax/vagrant-vmck"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_path  = "lib"

  spec.add_dependency "faraday"
  spec.add_dependency "json"
  spec.add_dependency "log4r"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3"
end
