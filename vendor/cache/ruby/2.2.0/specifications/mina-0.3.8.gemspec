# -*- encoding: utf-8 -*-
# stub: mina 0.3.8 ruby lib

Gem::Specification.new do |s|
  s.name = "mina"
  s.version = "0.3.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Rico Sta. Cruz", "Michael Galero"]
  s.date = "2016-01-04"
  s.description = "Really fast deployer and server automation tool."
  s.email = ["rico@nadarei.co", "mikong@nadarei.co"]
  s.executables = ["mina"]
  s.files = ["bin/mina"]
  s.homepage = "http://github.com/nadarei/mina"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "Really fast deployer and server automation tool."

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<open4>, ["~> 1.3.4"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0.0"])
      s.add_development_dependency(%q<pry>, ["~> 0.9.0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<open4>, ["~> 1.3.4"])
      s.add_dependency(%q<rspec>, ["~> 3.0.0"])
      s.add_dependency(%q<pry>, ["~> 0.9.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<open4>, ["~> 1.3.4"])
    s.add_dependency(%q<rspec>, ["~> 3.0.0"])
    s.add_dependency(%q<pry>, ["~> 0.9.0"])
  end
end
