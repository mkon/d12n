source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'byebug'

  gem 'rspec', '~> 3.9'
  gem 'rubocop', '1.56.4'
  gem 'rubocop-rspec', '2.24.1'
end

if (version = ENV['ACTIVESUPPORT'])
  gem 'activesupport', "~> #{version}.0"
end
