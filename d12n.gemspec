$LOAD_PATH.push File.expand_path('lib', __dir__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'd12n'
  s.version     = ENV.fetch 'VERSION', '0.1.4'
  s.authors     = ['Konstantin Munteanu']
  s.email       = ['konstantin@munteanu.de']
  s.homepage    = 'https://github.com/mkon/d12n'
  s.summary     = 'Delocalization'
  s.description = 'Delocalize numbers'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 3.0', '< 4'

  s.files = Dir['lib/**/*', 'LICENSE', 'README.md']

  s.add_dependency 'activesupport', '>= 6.1', '< 8'
  s.add_dependency 'i18n', '>= 0.7', '< 2'

  s.metadata['rubygems_mfa_required'] = 'true'
end
