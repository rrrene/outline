ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "authlogic/test_case"

require "helpers/test_login_helper"
require 'helpers/test_difference_helper'
require 'functional/helpers/content_item_resources'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Authlogic::TestCase
  setup :activate_authlogic
  include TestLoginHelper
  
  include TestDifferenceHelper
end
