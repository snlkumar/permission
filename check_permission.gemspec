# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'check_permission/version'

Gem::Specification.new do |spec|
  spec.name          = "check_permission"
  spec.version       = CheckPermission::VERSION
  spec.authors       = ["sunil"]
  spec.email         = ["sunil.kumar.14@netsolutionsindia.com"]

  spec.summary       = %q{To set the action based permission for the user and check the has_permission for the action.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/sunil-netsol/permission"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files`.split("\n").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
