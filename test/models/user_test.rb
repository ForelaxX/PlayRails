require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new name: 'name', email: '1@163.com'
  end

  test "user name should be present" do
    @user.name = ''
    assert_not @user.valid?
    end

  test "user email should be present" do
    @user.email = ''
    assert_not @user.valid?
  end

  test "user name can not be too long" do
    @user.name = '#' * 21
    assert_not @user.valid?
  end

  test "user email can not be too long" do
    @user.name = '#' * 44 + '@163.com'
    assert_not @user.valid?
  end

  test "user email should in valid format" do
    valid_mails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_mails.each do |valid_mail|
      @user.email = valid_mail
      assert @user.valid?, "#{@user.email} should be valid"
    end
  end

  test "email address should be unique" do
    another_user = @user.dup
    another_user.email.upcase
    @user.save
    assert_not another_user.valid?
  end
end
