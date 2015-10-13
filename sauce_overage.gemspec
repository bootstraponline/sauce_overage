require_relative 'lib/sauce_overage/version'

# rubocop:disable Style/SpaceAroundOperators

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 2.2.2'

  spec.name        = 'sauce_overage'
  spec.version     = SauceOverage::VERSION
  spec.date        = SauceOverage::DATE
  spec.license     = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  spec.description = spec.summary = (<<SUMMARY).strip
Automatically prevent tests from running on overage minutes by tracking remaining time
SUMMARY
  spec.description   += '.' # avoid identical warning
  spec.authors       = spec.email = ['code@bootstraponline.com']
  spec.homepage      = 'https://github.com/bootstraponline/sauce_overage'
  spec.require_paths = ['lib']
  spec.executables   = ['sauce_overage']

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.add_runtime_dependency 'hurley', '~> 0.2'
  spec.add_runtime_dependency 'multi_json', '~> 1.11.2'
  spec.add_runtime_dependency 'webdriver_utils', '~> 1.0.2'

  spec.add_development_dependency 'webmock', '~> 1.21.0'
  spec.add_development_dependency 'rspec', '~> 3.3.0'
  spec.add_development_dependency 'parallel_tests', '~> 1.7.0'
  spec.add_development_dependency 'appium_thor', '~> 1.0.1'
  spec.add_development_dependency 'coveralls', '~> 0.8.2'
  spec.add_development_dependency 'pry', '~> 0.10.1'
  spec.add_development_dependency 'bundler', '~> 1.10.6'
  spec.add_development_dependency 'rubocop', '~> 0.33.0'
end
