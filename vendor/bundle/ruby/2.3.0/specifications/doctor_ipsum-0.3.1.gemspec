# -*- encoding: utf-8 -*-
# stub: doctor_ipsum 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "doctor_ipsum"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nicholas Hwang"]
  s.date = "2013-08-15"
  s.description = "[\"Markdown Lorem Ipsum\"]"
  s.email = ["nick.joosung.hwang@gmail.com"]
  s.homepage = "https://github.com/geekjuice/doctor_ipsum"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "[\"Lorem Ipsum generator with Markdown formatting\"]"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
