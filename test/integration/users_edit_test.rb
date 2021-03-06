require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {name: "",
                                     email: "user@invalid",
                                     password: "foo",
                                     password_confirmation: "bar"}}
    assert_template 'users/edit'
    assert_select 'div[class="alert alert-danger"]', "The form contains 4 errors."

  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: {user: {name: name,
      email: email,
      password: "",
      password_confirmation: ""}}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email

  end

  test "successful edit with friendly forwarding" do
    # be redirected to edit user path if tried before
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    assert session[:forwarding_url].blank?
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: {user: {name: name,
      email: email,
      password: "",
      password_confirmation: ""}}
    assert_not flash.empty?
    # redirected to home if didn't try edit user path before
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email

  end

end
