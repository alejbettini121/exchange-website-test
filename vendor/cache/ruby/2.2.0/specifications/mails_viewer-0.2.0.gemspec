# -*- encoding: utf-8 -*-
# stub: mails_viewer 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mails_viewer"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Youcai Qian", "Dingding Ye"]
  s.date = "2018-01-27"
  s.description = "A mails preview Engine which provides a table view for all mails under tmp/mails."
  s.email = ["qycpublic@gmail.com", "yedingding@gmail.com"]
  s.homepage = "https://github.com/pragmaticly/mails_viewer"
  s.rubygems_version = "2.4.5"
  s.summary = "A mails preview Engine which provides a table view for all mails under tmp/mails."

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.1.0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 2.0.1"])
      s.add_runtime_dependency(%q<jquery-datatables-rails>, [">= 0"])
      s.add_development_dependency(%q<mail>, ["~> 2.4.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.11.0"])
    else
      s.add_dependency(%q<rails>, [">= 3.1.0"])
      s.add_dependency(%q<jquery-rails>, [">= 2.0.1"])
      s.add_dependency(%q<jquery-datatables-rails>, [">= 0"])
      s.add_dependency(%q<mail>, ["~> 2.4.0"])
      s.add_dependency(%q<rspec>, ["~> 2.11.0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.1.0"])
    s.add_dependency(%q<jquery-rails>, [">= 2.0.1"])
    s.add_dependency(%q<jquery-datatables-rails>, [">= 0"])
    s.add_dependency(%q<mail>, ["~> 2.4.0"])
    s.add_dependency(%q<rspec>, ["~> 2.11.0"])
  end
end
