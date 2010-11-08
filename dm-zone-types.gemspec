# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'dm-zone-types'
  s.version = '0.3'
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Neighman"]
  s.description = %q{Timezone aware datatypes for DataMapper}
  s.email = "has.sox@gmail.com"
  s.files = Dir.glob("{test,lib}/**/*.rb") +
            %w(Gemfile Gemfile.lock README.textile CHANGELOG Rakefile)
  s.homepage = %q{http://github.com/hassox/dm-zone-types}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Timezone aware datatypes for DataMapper}
  s.test_files = Dir.glob("test/**/*.rb")

  s.add_dependency 'dm-core'
  s.add_dependency 'activesupport', '>=3.0.0.beta3'
  s.add_dependency 'tzinfo'

  s.add_development_dependency 'nanotest'
  s.add_development_dependency 'nanotest_extensions'
  s.add_development_dependency 'watchr'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'dm-sqlite-adapter'
  s.add_development_dependency 'dm-migrations'
  s.add_development_dependency 'i18n'
  s.add_development_dependency 'dm-validations'
end
