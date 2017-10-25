# -*- encoding: utf-8 -*-
# stub: rails-assets-bootstrap.growl 3.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-assets-bootstrap.growl"
  s.version = "3.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["rails-assets.org"]
  s.date = "2015-04-29"
  s.description = "This is a simple plugin that turns standard Bootstrap alerts into \"Growl-like\" notifications."
  s.homepage = "http://bootstrap-notify.remabledesigns.com/"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "This is a simple plugin that turns standard Bootstrap alerts into \"Growl-like\" notifications."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails-assets-jquery>, [">= 1.10.2"])
      s.add_runtime_dependency(%q<rails-assets-bootstrap>, [">= 2.0.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rails-assets-jquery>, [">= 1.10.2"])
      s.add_dependency(%q<rails-assets-bootstrap>, [">= 2.0.0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails-assets-jquery>, [">= 1.10.2"])
    s.add_dependency(%q<rails-assets-bootstrap>, [">= 2.0.0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
