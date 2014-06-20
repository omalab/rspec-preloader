Gem::Specification.new do |gem|
  gem.name        = 'rspec-preloader'
  gem.version     = '0.0.3'
  gem.licenses    = ['MIT']
  gem.summary     = "A git backed preloader for rspec"
  gem.description = "Life is too short to be waiting for your tests to load."
  gem.authors     = ["Victor Mours"]
  gem.email       = 'victor.mours@gmail.com'
  gem.files       = Dir["lib/**/*.rb"]
  gem.executables = ["rspec-preloader"]
  gem.homepage    = 'https://github.com/victormours/rspec-preloader'

  gem.add_runtime_dependency "rspec"
  gem.add_runtime_dependency "git"

  gem.add_development_dependency "minitest"
  gem.add_development_dependency "pry"
end
