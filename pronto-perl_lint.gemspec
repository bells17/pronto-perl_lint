# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/perl_lint/version'

Gem::Specification.new do |spec|
  spec.name = 'pronto-perl_lint'
  spec.version = Pronto::PerlLintVersion::VERSION
  spec.authors = ['Daiki Hayakawa']
  spec.email = ['bells171@gmail.com']

  spec.summary = 'Pronto runner for Perl Lint'
  spec.homepage = 'https://github.com/belsl17/pronto-perl_lint'
  spec.license = 'MIT'

  spec.files = Dir.glob('lib/**/*.rb') +
              Dir.glob('bin/*') +
              ['pronto-perl_lint.gemspec', 'LICENSE', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency('pronto', '~> 0.8')
  spec.add_runtime_dependency('json', '~> 1.8')
  spec.add_runtime_dependency('github-linguist', '~> 5.0')
  spec.add_development_dependency('rake', '~> 11.0')
  spec.add_development_dependency('rspec', '~> 3.4')
end
