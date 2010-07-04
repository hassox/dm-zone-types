# -*- encoding: utf-8 -*-

require 'tumbler'
tumbler = Tumbler::GemspecHelper.new

Gem::Specification.new do |s|
  s.name = tumbler.name
  s.version = tumbler.version
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubyforge_project = tumbler.name
  s.authors = ["Daniel Neighman"]
  s.date = tumbler.date
  s.description = %q{Timezone aware datatypes for DataMapper}
  s.email = "has.sox@gmail.com"
  s.files = tumbler.files
  s.homepage = %q{http://github.com/hassox/dm-zone-types}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Timezone aware datatypes for DataMapper}
  s.test_files = tumbler.files(/^test/)

  # dependencies
  tumbler.inject_dependencies(s)
end
