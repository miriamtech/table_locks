$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "table_locks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "table_locks"
  s.version     = TableLocks::VERSION
  s.authors     = ["Miriam Technologies"]
  s.email       = ["developers@miriamtech.com"]
  s.homepage    = "http://www.miriamtech.com"
  s.summary     = "A concern that allows for application locking using Postgres table locks."
  s.description = "We developed table locks so we could have a method in our multi-headed Rails applications for ensuring that cron jobs did not run at the same time. Both frontends have an identical cron tab and will therefore try to run the job at the same time. If we use table_locks, whichever frontend executes first will run the job and the other will give up."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency "pg", "~> 0.20.0"
end
