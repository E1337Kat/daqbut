source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Server
gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'redis', '~>3.2'
gem 'figaro'
gem 'high_voltage', '~> 3.0.0'

# Authentication
gem 'devise'
gem 'omniauth-reddit', git: 'git://github.com/jackdempsey/omniauth-reddit.git'
gem 'omniauth-oauth2', '~> 1.3.1'

# Images
gem 'carrierwave', '~> 1.0'
gem 'fog-aws'
gem 'mini_magick'

# Templates
gem 'jbuilder', '~> 2.5'
gem 'text'
gem 'slim'
gem 'simple_form'
gem 'gruff'
gem 'kaminari'
gem 'sitemap_generator'
gem 'kramdown'

# Analytics
gem 'rollbar'
gem 'newrelic_rpm'
gem 'keen'
gem 'em-http-request', '~> 1.0'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
