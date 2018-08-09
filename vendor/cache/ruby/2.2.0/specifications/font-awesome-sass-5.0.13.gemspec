# -*- encoding: utf-8 -*-
# stub: font-awesome-sass 5.0.13 ruby lib

Gem::Specification.new do |s|
  s.name = "font-awesome-sass"
  s.version = "5.0.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Travis Chase"]
  s.date = "2018-05-14"
  s.description = "Font-Awesome SASS gem for use in Ruby projects"
  s.email = ["travis@fontawesome.com"]
  s.homepage = "https://github.com/FortAwesome/font-awesome-sass"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "Font-Awesome SASS"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sassc>, [">= 1.11"])
      s.add_development_dependency(%q<bundler>, [">= 1.3"])
      s.add_development_dependency(%q<compass>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<sassc>, [">= 1.11"])
      s.add_dependency(%q<bundler>, [">= 1.3"])
      s.add_dependency(%q<compass>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<sassc>, [">= 1.11"])
    s.add_dependency(%q<bundler>, [">= 1.3"])
    s.add_dependency(%q<compass>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
