# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'worksnaps'
  spec.license = 'MIT'
  spec.version = '0.0.1pre'
  spec.date = '2021-01-02'

  spec.authors = [
    'Brody Hoskins'
  ]
  spec.email = [
    'brody@brody.digital'
  ]

  spec.summary = 'API wrapper for Worksnaps'
  spec.description = <<~DESC.gsub(/\n/, ' ').strip
    API wrapper for Worksnaps
  DESC
  spec.homepage = 'https://github.com/brodyhoskins/worksnaps'

  spec.files = Dir['lib/**/*']
  spec.files += Dir['[A-Z]*'] + Dir['test/**/*']
  spec.files.reject! { |fn| fn.include? 'CVS' }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 6.0.0', '< 7.1'
  spec.add_dependency 'httparty', '~> 0.10'
  spec.add_dependency 'rexml', '~> 3.2.5'
  spec.add_dependency 'timezone', '1.3.23'
end
