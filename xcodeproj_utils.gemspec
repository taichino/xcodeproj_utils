# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcodeproj_utils/version'

Gem::Specification.new do |spec|
  spec.name          = "xcodeproj_utils"
  spec.version       = XcodeprojUtils::VERSION
  spec.authors       = ["Matsumoto Taichi"]
  spec.email         = ["taichino@gmail.com"]
  spec.summary       = %q{Count source lines of files in xcode project.}
  spec.description   = %q{Count source lines of files in xcode project.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "thor"

  spec.add_runtime_dependency "xcodeproj"
end
