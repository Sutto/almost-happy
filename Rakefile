require 'rubygems'
require 'rake'
require 'lib/almost_happy'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "almost-happy"
    gem.summary     = %Q{Simple tools for AR + Rails 3 to help make managing your content easy}
    gem.description = %Q{Helpers, convertors etc for Rails 3 to make page / post models for simple cases simple}
    gem.email       = "sutto@sutto.net"
    gem.homepage    = "http://github.com/Sutto/almost-happy"
    gem.authors     = ["Darcy Laycock"]
    gem.version     = AlmostHappy::VERSION
    gem.add_dependency "activerecord", ">= 3.0.0.beta3"
    gem.add_dependency "RedCloth"
    gem.add_dependency "rdiscount"
    gem.add_dependency "nokogiri"
    gem.add_development_dependency "shoulda", ">= 0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "almost-happy #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
