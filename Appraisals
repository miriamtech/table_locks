ruby_version = Gem::Version.new(RUBY_VERSION)
if ruby_version < Gem::Version.new('2.6.0')
  appraise 'rails-4' do
    gem 'rails', '4.2.11.3'
    gem 'pg', '~> 0.21.0' # Newer versions have an irritating deprecation warning in Rails 4.2
    gem 'nokogiri', '< 1.13' # 1.13 removes support for ruby 2.5
  end
end

if ruby_version < Gem::Version.new('3.0.0')
  appraise 'rails-5' do
    gem 'rails', '5.2.8.1'
  end
end

appraise 'rails-6' do
  gem 'rails', '6.1.7.6'
end

if ruby_version >= Gem::Version.new('2.7.0')
  appraise 'rails-7' do
    gem 'rails', '7.1.1'
  end

  appraise 'rails-edge' do
    gem 'rails', github: 'rails/rails', branch: 'main'
  end
end
