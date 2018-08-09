# -*- encoding: utf-8 -*-
# stub: mina-slack 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "mina-slack".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["TAKAyuki_atkwsk".freeze]
  s.date = "2018-07-26"
  s.description = "Slack web hook from mina".freeze
  s.email = ["takagi.takayuki.yuuki@gmail.com".freeze]
  s.files = [".gitignore".freeze, "Gemfile".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "lib/mina/slack.rb".freeze, "lib/mina/slack/tasks.rb".freeze, "lib/mina/slack/tasks/mina-slack.rake".freeze, "lib/mina/slack/version.rb".freeze, "mina-slack.gemspec".freeze]
  s.homepage = "https://github.com/TAKAyukiatkwsk/mina-slack".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Slack web hook from mina".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>.freeze, ["~> 1.6.7"])
      s.add_runtime_dependency(%q<mina>.freeze, ["~> 0.3.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rest-client>.freeze, ["~> 1.6.7"])
      s.add_dependency(%q<mina>.freeze, ["~> 0.3.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rest-client>.freeze, ["~> 1.6.7"])
    s.add_dependency(%q<mina>.freeze, ["~> 0.3.0"])
  end
end
