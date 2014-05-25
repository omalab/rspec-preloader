Gem::Specification.new do |gem|
  gem.name        = 'rspec-preloader'
  gem.version     = '0.0.0'
  gem.summary     = "A faster way to run your specs."
  gem.description = "A prealoader for you spec helper for faster TDD"
  gem.authors     = ["Victor Mours"]
  gem.email       = 'victor.mours@gmail.com'
  gem.files       = ["lib/rspec_preloader.rb"]
  gem.homepage    = 'https://github.com/victormours/rspec-preloader'

  gem.add_development_dependency "minitest"
end