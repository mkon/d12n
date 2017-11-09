$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'd12n'
  s.version     = ENV.fetch 'VERSION', '0.0.2'
  s.authors     = ['mkon']
  s.email       = ['konstantin@munteanu.de']
  s.homepage    = 'https://github.com/mkon'
  s.summary     = 'Delocalization'
  s.description = 'Delocalize numbers'
  s.license     = 'MIT'

  s.files = Dir['lib/**/*', 'README.md']

  s.add_dependency 'activesupport', '>= 5.0.2', '< 6'

  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rubocop', '~> 0'
end
