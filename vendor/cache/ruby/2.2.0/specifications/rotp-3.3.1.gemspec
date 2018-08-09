# -*- encoding: utf-8 -*-
# stub: rotp 3.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rotp"
  s.version = "3.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mark Percival"]
  s.date = "2018-03-02"
  s.description = "Works for both HOTP and TOTP, and includes QR Code provisioning"
  s.email = ["mark@markpercival.us"]
  s.executables = ["rotp"]
  s.files = ["bin/rotp"]
  s.homepage = "http://github.com/mdp/rotp"
  s.licenses = ["MIT"]
  s.rubyforge_project = "rotp"
  s.rubygems_version = "2.4.5"
  s.summary = "A Ruby library for generating and verifying one time passwords"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["~> 10.5"])
      s.add_development_dependency(%q<rspec>, ["~> 3.5"])
      s.add_development_dependency(%q<timecop>, ["~> 0.8"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.12"])
    else
      s.add_dependency(%q<rake>, ["~> 10.5"])
      s.add_dependency(%q<rspec>, ["~> 3.5"])
      s.add_dependency(%q<timecop>, ["~> 0.8"])
      s.add_dependency(%q<simplecov>, ["~> 0.12"])
    end
  else
    s.add_dependency(%q<rake>, ["~> 10.5"])
    s.add_dependency(%q<rspec>, ["~> 3.5"])
    s.add_dependency(%q<timecop>, ["~> 0.8"])
    s.add_dependency(%q<simplecov>, ["~> 0.12"])
  end
end
