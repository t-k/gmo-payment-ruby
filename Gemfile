source 'https://rubygems.org/'

group :development do
  gem "yard"
end

group :development, :test do
  gem 'guard'
  gem 'guard-rspec'
  gem 'simplecov'
  gem "pry"

  if RUBY_PLATFORM =~ /darwin/
    gem "ruby_gntp"
    gem "rb-fsevent"
  end
  if RUBY_PLATFORM =~ /linux/
    gem 'libnotify'
    gem 'rb-inotify'
  end
end

gemspec
