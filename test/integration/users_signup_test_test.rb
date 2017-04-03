require 'test_helper'

class UsersSignupTestTest < ActionDispatch::IntegrationTest
  test "user sign invalid" do
    get signup_path
    assert_no_difference User.count.to_s do
      post users_path, params: {
          user: {
              name: '',
              email: '',
              password: '',
              password_confirmation: ''
          }
      }
    end
    assert_template 'users/new'
  end
end
