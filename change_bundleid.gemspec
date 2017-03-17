# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'change_bundleid/version'

Gem::Specification.new do |spec|
  spec.name          = "change_bundleid"
  spec.version       = ChangeBundleid::VERSION
  spec.authors       = ["Fabio Gallonetto"]
  spec.email         = ["fabio@futureworkshops.com"]

  spec.summary       = "A tool to change the bundle identifier of an Xcode project"
  spec.description   = "A tool to change the bundle identifier of an Xcode project"
  spec.homepage      = "http://www.github.com/FutureWorkshops/ChangeBundleID"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables    = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "xcodeproj", "~> 1.4.2"
  spec.add_dependency "plist", "~> 3.2.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
