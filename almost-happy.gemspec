require File.expand_path('./lib/almost_happy', File.dirname(__FILE__))

Gem::Specification.new do |s|

  s.name        = "almost-happy"
  s.summary     = %Q{Simple tools for AR + Rails 3 to help make managing your content easy}
  s.description = %Q{Helpers, convertors etc for Rails 3 to make page / post models for simple cases simple}
  s.email       = "sutto@sutto.net"
  s.homepage    = "http://github.com/Sutto/almost-happy"
  s.authors     = ["Darcy Laycock"]
  s.version     = AlmostHappy::VERSION.dup

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "activerecord", "~> 3.0"
  s.add_dependency "RedCloth"
  s.add_dependency "rdiscount"
  s.add_dependency "nokogiri"
  s.add_dependency "open4" # For albino
  s.add_development_dependency "shoulda", ">= 0"
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'reversible_data'

end