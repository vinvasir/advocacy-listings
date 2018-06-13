require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  def setup
    @user_1 = FactoryBot.create(:user)
    @user_2 = FactoryBot.create(:user)
    @user_3 = FactoryBot.create(:user)
  end

  test "allows users to have favorite organizations and orgs to have favoriters" do
    
  end
end