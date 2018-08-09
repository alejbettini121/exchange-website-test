# -*- encoding: utf-8 -*-
# stub: bourbon 5.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bourbon"
  s.version = "5.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Christian Reuter", "Damian Galarza", "Gabe Berke-Williams", "Hugo Giraudel", "Joshua Ogle", "Kyle Fiedler", "Phil LaPier", "Reda Lemeden", "Tyson Gach", "Will McMahan"]
  s.date = "2018-07-20"
  s.description = "    Bourbon is a library of pure Sass mixins and functions that are designed to\n    make you a more efficient developer.\n"
  s.email = "design+bourbon@thoughtbot.com"
  s.executables = ["bourbon"]
  s.files = ["bin/bourbon"]
  s.homepage = "https://www.bourbon.io/"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "A lightweight Sass tool set."

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<aruba>, ["~> 0.14"])
      s.add_development_dependency(%q<css_parser>, ["~> 1.4"])
      s.add_development_dependency(%q<cucumber>, ["~> 2.0"])
      s.add_development_dependency(%q<rake>, ["~> 11.1"])
      s.add_development_dependency(%q<rspec>, ["~> 3.4"])
      s.add_development_dependency(%q<scss_lint>, ["= 0.48"])
      s.add_runtime_dependency(%q<sass>, ["~> 3.4"])
      s.add_runtime_dependency(%q<thor>, ["~> 0.19"])
    else
      s.add_dependency(%q<aruba>, ["~> 0.14"])
      s.add_dependency(%q<css_parser>, ["~> 1.4"])
      s.add_dependency(%q<cucumber>, ["~> 2.0"])
      s.add_dependency(%q<rake>, ["~> 11.1"])
      s.add_dependency(%q<rspec>, ["~> 3.4"])
      s.add_dependency(%q<scss_lint>, ["= 0.48"])
      s.add_dependency(%q<sass>, ["~> 3.4"])
      s.add_dependency(%q<thor>, ["~> 0.19"])
    end
  else
    s.add_dependency(%q<aruba>, ["~> 0.14"])
    s.add_dependency(%q<css_parser>, ["~> 1.4"])
    s.add_dependency(%q<cucumber>, ["~> 2.0"])
    s.add_dependency(%q<rake>, ["~> 11.1"])
    s.add_dependency(%q<rspec>, ["~> 3.4"])
    s.add_dependency(%q<scss_lint>, ["= 0.48"])
    s.add_dependency(%q<sass>, ["~> 3.4"])
    s.add_dependency(%q<thor>, ["~> 0.19"])
  end
end
