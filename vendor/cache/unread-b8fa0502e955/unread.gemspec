# -*- encoding: utf-8 -*-
# stub: unread 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "unread".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Georg Ledermann".freeze]
  s.date = "2018-07-26"
  s.description = "This gem creates a scope for unread objects and adds methods to mark objects as read ".freeze
  s.email = ["mail@georg-ledermann.de".freeze]
  s.files = [".gitignore".freeze, ".travis.yml".freeze, "Gemfile".freeze, "MIT-LICENSE".freeze, "README.md".freeze, "Rakefile".freeze, "ci/Gemfile-rails-3-0".freeze, "ci/Gemfile-rails-3-1".freeze, "ci/Gemfile-rails-3-2".freeze, "ci/Gemfile-rails-4-0".freeze, "ci/Gemfile-rails-4-1".freeze, "lib/generators/unread/migration/migration_generator.rb".freeze, "lib/generators/unread/migration/templates/migration.rb".freeze, "lib/unread.rb".freeze, "lib/unread/base.rb".freeze, "lib/unread/read_mark.rb".freeze, "lib/unread/readable.rb".freeze, "lib/unread/reader.rb".freeze, "lib/unread/scopes.rb".freeze, "lib/unread/version.rb".freeze, "spec/base_spec.rb".freeze, "spec/model/email.rb".freeze, "spec/model/reader.rb".freeze, "spec/read_mark_spec.rb".freeze, "spec/readable_spec.rb".freeze, "spec/spec_helper.rb".freeze, "spec/support/matchers/perform_queries.rb".freeze, "spec/support/query_counter.rb".freeze, "spec/support/timecop.rb".freeze, "unread.gemspec".freeze]
  s.homepage = "".freeze
  s.rubyforge_project = "unread".freeze
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Manages read/unread status of ActiveRecord objects".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<timecop>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
  end
end
