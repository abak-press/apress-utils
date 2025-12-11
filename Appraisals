# frozen_string_literal: true

if RUBY_VERSION < '2.7'
  appraise 'rails4.2' do
    gem 'rails', '~> 4.2.0'
    gem 'combustion', '= 0.5.2'
    gem 'pg', '< 1.0', require: false
  end

  appraise 'rails5.0' do
    gem 'rails', '~> 5.0.7'
    gem 'pg', '< 1.0', require: false
  end

  # appraise 'rails5.1' do
  #   gem 'rails', '~> 5.1.7'
  #   gem 'pg', '< 1.0', require: false
  # end
end
