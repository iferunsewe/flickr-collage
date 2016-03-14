# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flickit/version'

Gem::Specification.new do |spec|
  spec.name          = "flickit"
  spec.version       = FlickIt::VERSION
  spec.authors       = ["iferunsewe"]
  spec.email         = ["iferunsewe@gmail.com"]

  spec.summary       = "Create collage of flickr images"
  spec.description   = "Creates collage of flickr images. Includes random words if less than ten arguments are entered."
  spec.homepage      = "https://github.com/iferunsewe/flickr-collage"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ["flickit"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
