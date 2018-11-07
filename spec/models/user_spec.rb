require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      first_name: 'Tim', last_name: 'Arnold', user_type: 'admin',
      password: 'timothyarnold1', username: 'tarnold'
    )
  end

  test 'user should be valid when first_name, last_name, user_type, password,
        and username are present' do
    assert users(:admin).valid?
  end

  test 'user should be invalid when first_name is empty' do
    @user.first_name = '   '
    assert_not @user.valid?
  end

  test 'user should be invalid when last_name is empty' do
    @user.last_name = '   '
    assert_not @user.valid?
  end

  test 'user should be invalid when user_type is empty' do
    @user.user_type = '    '
    assert_not @user.valid?
  end

  test 'user should be invalid when password is empty' do
    @user.password = '    '
    assert_not @user.valid?
  end

  test 'user should be invalid when username is empty' do
    @user.username = '   '
    assert_not @user.valid?
  end

  test 'user should be invalid when first_name is not present' do
    @user.first_name = nil
    assert_not @user.valid?
  end

  test 'user should be invalid when last_name is not present' do
    @user.last_name = nil
    assert_not @user.valid?
  end

  test 'user should be invalid when user_type is not present' do
    @user.user_type = nil
    assert_not @user.valid?
  end

  test 'user should be invalid when password is not present' do
    @user.password = nil
    assert_not @user.valid?
  end

  test 'user should be invalid when username is not present' do
    @user.username = nil
    assert_not @user.valid?
  end

  test 'first_name should not be longer than 50 characters' do
    @user.first_name = 'a' * 51
    assert_not @user.valid?
  end

  test 'last_name should not be longer than 50 characters' do
    @user.last_name = 'a' * 51
    assert_not @user.valid?
  end

  test 'username should not be longer than 50 characters' do
    @user.username = 'a' * 51
    assert_not @user.valid?
  end

  test 'password should not be less than 6 characters' do
    @user.password = 'a' * 5
    assert_not @user.valid?
  end

  test 'username should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'username should be saved as lower case' do
    mixed_case_username = 'UseRNaMe'
    @user.username = mixed_case_username
    @user.save
    assert_equal mixed_case_username.downcase, @user.reload.username
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'has and belongs to many groups' do
    association = User.reflect_on_association(:groups)
    assert_same association.macro, :has_and_belongs_to_many
  end

  test 'has and belongs to many notifications' do
    association = User.reflect_on_association(:notifications)
    assert_same association.macro, :has_and_belongs_to_many
  end
end
