$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'simple_audit_trail/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'simple_audit_trail'
  s.version     = SimpleAuditTrail::VERSION
  s.licenses    = ['MIT']
  s.authors     = ['Christopher Maujean']
  s.email       = ['cmaujean@repairpal.com']
  s.homepage    = 'http://github.com/RepairPal/simple_audit_trail'
  s.summary     = 'a simple audit trail plugin for active record models'
  s.description = "
    A simple audit trail for your ActiveRecord model, with a minimum of fuss.
    stores a before and after hash of the fields you want audited, whenever a
    change is made.
  "

  s.files = Dir['{app,db,lib,config}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4', '>= 4.0.0'

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
end
