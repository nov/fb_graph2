Gem::Specification.new do |gem|
  gem.name          = 'fb_graph2'
  gem.version       = File.read('VERSION').delete("\n\r")
  gem.authors       = ['nov matake']
  gem.email         = ['nov@matake.jp']
  gem.summary       = %q{Facebook Graph API v2.0 Wrapper in Ruby}
  gem.description   = %q{Facebook Graph API v2.0 Wrapper in Ruby}
  gem.homepage      = 'https://github.com/fb_graph2'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'httpclient', '>= 2.3'
  gem.add_runtime_dependency 'rack-oauth2', '>= 1.0'
  gem.add_runtime_dependency 'multi_json'
  gem.add_runtime_dependency 'activesupport', '>= 4.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'rspec', '>= 2'
end
