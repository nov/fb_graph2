Gem::Specification.new do |gem|
  gem.name          = 'fb_graph2'
  gem.version       = File.read('VERSION').delete("\n\r")
  gem.authors       = ['nov matake']
  gem.email         = ['nov@matake.jp']
  gem.summary       = %q{Facebook Graph API v2.x Wrapper in Ruby}
  gem.description   = %q{Facebook Graph API v2.x Wrapper in Ruby}
  gem.homepage      = 'https://github.com/nov/fb_graph2'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'httpclient', '>= 2.4'
  gem.add_runtime_dependency 'rack-oauth2', '>= 1.1'
  gem.add_runtime_dependency 'url_safe_base64'
  gem.add_runtime_dependency 'multi_json'
  gem.add_runtime_dependency 'activesupport', '>= 3.2'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-its'
end
