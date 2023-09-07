source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'byebug'

  gem 'rspec', '~> 3.9'
  gem 'rubocop', '1.56.1'
  gem 'rubocop-rspec', '2.23.0'
end

if (version = ENV['ACTIVESUPPORT'])
  gem 'activesupport', "~> #{version}.0"
end
