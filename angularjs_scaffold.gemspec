$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "angularjs_scaffold/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "angularjs_scaffold"
  s.version     = AngularjsScaffold::VERSION
  s.authors     = ["lol Your name"]
  s.email       = ["lol Your email"]
  s.homepage    = "http://ricodigo.com"
  s.summary     = "lol Summary of AngularjsScaffold."
  s.description = "lol Description of AngularjsScaffold."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
