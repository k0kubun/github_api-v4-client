# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github_api/v4/client/version'

Gem::Specification.new do |spec|
  spec.name          = 'github_api-v4-client'
  spec.version       = GithubApi::V4::Client::VERSION
  spec.authors       = ['Takashi Kokubun']
  spec.email         = ['takashikkbn@gmail.com']

  spec.summary       = %q{A very thin GitHub GraphQL API v4 client}
  spec.description   = %q{A very thin GitHub GraphQL API v4 client}
  spec.homepage      = 'https://github.com/k0kubun/github_api-v4-client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3.0' # for <<~HEREDOC

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
