$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "railstrap/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "railstrap"
  s.version     = Railstrap::VERSION
  s.authors     = ["Allan Freitas"]
  s.email       = ["allanfreitasci@gmail.com"]
  s.homepage    = "http"
  s.summary     = "Bootstrap Tools for Rails 3, Generate Layouts and CRUDs, Helpers and more...."
  s.description = "Bootstrap Tools for Rails 3, Generate Layouts and CRUDs, Helpers and more...."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"
  #s.add_dependency "bootstrap-sass", "~> 2.0.3"
  s.add_dependency "bootstrap-sass", ">= 2.0.3"
  
  #helpers para Tabelas
  s.add_dependency "table_for_collection", ">= 1.0.6"

  #paginacao
  s.add_dependency "kaminari", ">= 0.13.0"

  #formulario
  s.add_dependency "simple_form", ">= 2.0.2"
  #nested_forms
  s.add_dependency "cocoon", ">= 1.0.21"

  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
