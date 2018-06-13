ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# require 'support/factory_bot'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
end
