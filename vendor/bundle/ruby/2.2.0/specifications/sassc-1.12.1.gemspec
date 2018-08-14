# -*- encoding: utf-8 -*-
# stub: sassc 1.12.1 ruby lib
# stub: ext/Rakefile

Gem::Specification.new do |s|
  s.name = "sassc"
  s.version = "1.12.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ryan Boland"]
  s.date = "2018-07-05"
  s.description = "Use libsass with Ruby!"
  s.email = ["ryan@tanookilabs.com"]
  s.extensions = ["ext/Rakefile"]
  s.files = ["ext/Rakefile"]
  s.homepage = "https://github.com/sass/sassc-ruby"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Use libsass with Ruby!"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, ["~> 5.5.1"])
      s.add_development_dependency(%q<minitest-around>, [">= 0"])
      s.add_development_dependency(%q<test_construct>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_runtime_dependency(%q<ffi>, ["~> 1.9.6"])
      s.add_runtime_dependency(%q<sass>, [">= 3.3.0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, ["~> 5.5.1"])
      s.add_dependency(%q<minitest-around>, [">= 0"])
      s.add_dependency(%q<test_construct>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<ffi>, ["~> 1.9.6"])
      s.add_dependency(%q<sass>, [">= 3.3.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, ["~> 5.5.1"])
    s.add_dependency(%q<minitest-around>, [">= 0"])
    s.add_dependency(%q<test_construct>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<ffi>, ["~> 1.9.6"])
    s.add_dependency(%q<sass>, [">= 3.3.0"])
  end
end
