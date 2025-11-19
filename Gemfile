source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'byebug'

  gem 'rspec', '~> 3.9'
  gem 'rubocop', '1.60.2'
  gem 'rubocop-rspec', '3.8.0'
end

if (version = ENV['ACTIVESUPPORT'])
  gem 'activesupport', "~> #{version}.0"
end
