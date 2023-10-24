ruby_version = Gem::Version.new(RUBY_VERSION)

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
