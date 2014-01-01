source 'https://rubygems.org/'

group :development do
  gem "yard"
end

group :development, :test do
  if RUBY_VERSION >= "1.9.3"
    gem 'guard'
    gem 'guard-rspec'
  end
  gem 'simplecov'

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
