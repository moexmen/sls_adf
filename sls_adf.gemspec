#sls_adf: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sls_adf/version'

Gem::Specification.new do |s|
  s.name          = 'sls_adf'
  s.version       = SlsAdf::VERSION
  s.authors       = ['Toh Weiqing']
  s.email         = ['hello@estl.moe']

  s.summary       = 'Ruby client library for SLS (in progress).'
  s.description   = "Ruby client library for SLS's Application Development Framework (in progress)."
  s.homepage      = 'https://github.com/moexmen/sls-adf'
  s.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = 'http://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|s|features)/})
  end
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'graphql-client', '~>0.12'
  s.add_dependency 'http', '~>3.0'

  s.add_development_dependency 'bundler', '~> 1.16'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'dotenv', '~> 2.2'
  s.add_development_dependency 'rdoc'
end
