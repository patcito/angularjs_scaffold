$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "angularjs_scaffold/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "angularjs_scaffold"
  s.version     = AngularjsScaffold::VERSION
  s.authors     = ["Patrick Aljord"]
  s.email       = ["patcito@gmail.com"]
  s.homepage    = "http://ricodigo.com"
  s.summary     = "Angularjs scaffolding."
  s.description = "A rails plugin for scaffolding views using Angular.js, Twitter bootstrap and font awesome."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
