# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcodeproj_utils/version'

Gem::Specification.new do |spec|
  spec.name          = "xcodeproj_utils"
  spec.version       = XcodeprojUtils::VERSION
  spec.authors       = ["Matsumoto Taichi"]
  spec.email         = ["taichino@gmail.com"]
  spec.summary       = %q{Util commands for xcode project.}
  spec.description   = %q{
Util commands for xcode project. Following commands are supported for now.

- Count source lines of files in xcode project
- Show source / resource files in xcode project
}
  spec.homepage      = "https://github.com/taichino/xcodeproj_utils"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "thor", "~> 0.18"
  spec.add_runtime_dependency "xcodeproj", "~> 0.14"
end
