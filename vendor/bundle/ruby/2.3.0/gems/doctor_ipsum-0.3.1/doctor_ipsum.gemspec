# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doctor_ipsum/version'

Gem::Specification.new do |spec|
  spec.name          = "doctor_ipsum"
  spec.version       = DoctorIpsum::VERSION
  spec.authors       = ["Nicholas Hwang"]
  spec.email         = ["nick.joosung.hwang@gmail.com"]
  spec.description   = ["Markdown Lorem Ipsum"]
  spec.summary       = ["Lorem Ipsum generator with Markdown formatting"]
  spec.homepage      = "https://github.com/geekjuice/doctor_ipsum"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
