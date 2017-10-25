# -*- encoding: utf-8 -*-
# stub: lerolero_generator 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "lerolero_generator"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jackson Pires"]
  s.date = "2014-04-12"
  s.description = "Gerador de Lero-Lero."
  s.email = ["jackson.pires@gmail.com"]
  s.homepage = "https://github.com/jacksonpires/lerolero_generator"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "O gerador de Lero-Lero pode gerar at\u{e9} 10 mil combina\u{e7}\u{f5}es diferentes de frases de embroma\u{e7}\u{e3}o."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14.1"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.14.1"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.14.1"])
  end
end
