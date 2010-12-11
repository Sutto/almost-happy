# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{almost-happy}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Darcy Laycock"]
  s.date = %q{2010-12-11}
  s.description = %q{Helpers, convertors etc for Rails 3 to make page / post models for simple cases simple}
  s.email = %q{sutto@sutto.net}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".document",
    "LICENSE",
    "README.md",
    "Rakefile",
    "almost-happy.gemspec",
    "lib/almost-happy.rb",
    "lib/almost_happy.rb",
    "lib/almost_happy/active_record_mixin.rb",
    "lib/almost_happy/convertable.rb",
    "lib/almost_happy/convertor.rb",
    "lib/almost_happy/format_validator.rb",
    "lib/almost_happy/publishable.rb",
    "lib/almost_happy/scopeable.rb",
    "lib/vendor/albino.rb",
    "test/helper.rb",
    "test/test_almost-happy.rb"
  ]
  s.homepage = %q{http://github.com/Sutto/almost-happy}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Simple tools for AR + Rails 3 to help make managing your content easy}
  s.test_files = [
    "test/helper.rb",
    "test/test_almost-happy.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0.0.beta3"])
      s.add_runtime_dependency(%q<RedCloth>, [">= 0"])
      s.add_runtime_dependency(%q<rdiscount>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<open4>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.0.0.beta3"])
      s.add_dependency(%q<RedCloth>, [">= 0"])
      s.add_dependency(%q<rdiscount>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<open4>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.0.0.beta3"])
    s.add_dependency(%q<RedCloth>, [">= 0"])
    s.add_dependency(%q<rdiscount>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<open4>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
  end
end

