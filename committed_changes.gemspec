$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "committed_changes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "committed_changes"
  s.version     = CommittedChanges::VERSION
  s.authors     = ["Mariusz Pietrzyk"]
  s.email       = ["wijet@wijet.pl"]
  s.homepage    = "https://github.com/wijet/committed_changes"
  s.summary     = "committed_changes hash for ActiveRecord models"
  s.description = %{
    A Ruby on Rails plugin which provides hash with changes committed to the database
    when the changes hash is already cleared.
  }

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.1"

  s.add_development_dependency "sqlite3"
end
