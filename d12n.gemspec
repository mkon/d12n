$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'd12n'
  s.version     = ENV.fetch 'VERSION', '0.1.1'
  s.authors     = ['Konstantin Munteanu']
  s.email       = ['konstantin@munteanu.de']
  s.homepage    = 'https://github.com/mkon/d12n'
  s.summary     = 'Delocalization'
  s.description = 'Delocalize numbers'
  s.license     = 'MIT'

  s.files = Dir['lib/**/*', 'LICENSE', 'README.md']

  s.add_dependency 'activesupport', '>= 4.2', '< 6'
  s.add_dependency 'i18n', '~> 0.7'

  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rubocop', '~> 0'
end
