# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-assets-bootstrap.growl/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-assets-bootstrap.growl"
  spec.version       = RailsAssetsBootstrapGrowl::VERSION
  spec.authors       = ["rails-assets.org"]
  spec.description   = "This is a simple plugin that turns standard Bootstrap alerts into \"Growl-like\" notifications."
  spec.summary       = "This is a simple plugin that turns standard Bootstrap alerts into \"Growl-like\" notifications."
  spec.homepage      = "http://bootstrap-notify.remabledesigns.com/"
  spec.license       = "MIT"

  spec.files         = `find ./* -type f | cut -b 3-`.split($/)
  spec.require_paths = ["lib"]

  spec.add_dependency "rails-assets-jquery", ">= 1.10.2"
  spec.add_dependency "rails-assets-bootstrap", ">= 2.0.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
