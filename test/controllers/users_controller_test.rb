require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @non_activated = users(:ghost)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  test "should redirect to root when get non_activated user_path" do
    log_in_as(@user)
    get user_path(@non_activated)
    assert_redirected_to root_url
  end

  test "should show user when get activated user_path" do
    log_in_as(@user)
    get user_path(@other_user)
    assert_template 'users/show'
  end
  
  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end
  
  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
end
