require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new name: 'name', email: '1@163.com',
        password: 'foobar', password_confirmation: 'foobar'
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

  test "user email should be saved as lowercase" do
    upper_email = "EMAMPLE@qq.com"
    @user.email = upper_email
    @user.save
    assert_equal @user.reload.email, upper_email.downcase
  end

  test 'user passwd should be present' do
    @user.password = @user.password_confirmation = ''
    assert_not @user.valid?
  end

  test 'user passwd should have minimum length' do
    @user.password = @user.password_confirmation = '1' * 5
    assert_not @user.valid?
  end
end
