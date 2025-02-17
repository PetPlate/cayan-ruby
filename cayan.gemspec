lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cayan/version'

Gem::Specification.new do |spec|
  spec.name          = 'cayan'
  spec.version       = Cayan::VERSION
  spec.authors       = ['Cohub, Inc.']
  spec.email         = ['engineering@cohub.com']

  spec.summary       = %q{Ruby gem to communicate with Cayan's API's}
  spec.description   = %q{API wrapper for communicating with Cayan's API's}
  spec.homepage      = 'https://github.com/cohubinc/cayan-ruby'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.16'
  spec.add_development_dependency 'minitest', '>= 5.0'
  spec.add_development_dependency 'pry', '>= 0.11.3'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'webmock', '>= 3.4.2'

  spec.add_dependency 'savon', '>= 2.12.0'
end
