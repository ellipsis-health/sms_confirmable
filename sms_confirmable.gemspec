$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sms_confirmable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sms_confirmable"
  s.version     = SmsConfirmable::VERSION
  s.authors     = ["Dieterich Lawson"]
  s.email       = ["dieterich.lawson@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SmsConfirmable."
  s.description = "TODO: Description of SmsConfirmable."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "scrypt", "~> 1.1.0"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
