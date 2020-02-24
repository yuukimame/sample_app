require 'test_helper'

class UsersActivationTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @user_not_activated = users(:ghost)
  end

  test "index should not include not activated user" do
    log_in_as(@admin)
    get users_path
    assert_select 'a[href=?]', user_path(@user_not_activated), count: 0
  end

  test "show user who is not activated should redirect to root" do
    get user_path(@user_not_activated)
    assert_redirected_to root_url
  end
end