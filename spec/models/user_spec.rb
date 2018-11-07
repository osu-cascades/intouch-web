require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(
      first_name: 'Tim', last_name: 'Arnold', user_type: 'admin',
      password: 'timothyarnold1', username: 'tarnold'
    )
  end

  it 'is valid when first_name, last_name, user_type, password,
      and username are present' do
    expect(@user).to be_valid
  end

  it 'is invalid when first_name is blank' do
    @user.first_name = '   '
    expect(@user).to_not be_valid
  end

  it 'is invalid when last_name is blank' do
    @user.last_name = '   '
    expect(@user).to_not be_valid
  end

  it 'is invalid when user_type is blank' do
    @user.user_type = '    '
    expect(@user).to_not be_valid
  end

  it 'is invalid when password is blank' do
    @user.password = '    '
    expect(@user).to_not be_valid
  end

  it 'is invalid when username is blank' do
    @user.username = '   '
    expect(@user).to_not be_valid
  end

  it 'is invalid when first_name is not present' do
    @user.first_name = nil
    expect(@user).to_not be_valid
  end

  it 'is invalid when last_name is not present' do
    @user.last_name = nil
    expect(@user).to_not be_valid
  end

  it 'is invalid when user_type is not present' do
    @user.user_type = nil
    expect(@user).to_not be_valid
  end

  it 'is invalid when password is not present' do
    @user.password = nil
    expect(@user).to_not be_valid
  end

  it 'is invalid when username is not present' do
    @user.username = nil
    expect(@user).to_not be_valid
  end

  it 'is invalid when first_name is longer than 50 characters' do
    @user.first_name = 'a' * 51
    expect(@user).to_not be_valid
  end

  it 'is invalid when last_name is longer than 50 characters' do
    @user.last_name = 'a' * 51
    expect(@user).to_not be_valid
  end

  it 'is invalid when username is longer than 50 characters' do
    @user.username = 'a' * 51
    expect(@user).to_not be_valid
  end

  it 'is invalid when password is less than 6 characters' do
    @user.password = 'a' * 5
    expect(@user).to_not be_valid
  end

  it 'is invalid when username not unique' do
    @user.save
    duplicate_user = @user.dup
    expect(duplicate_user).to_not be_valid
  end

  it 'saves username as lowercase' do
    mixed_case_username = 'UseRNaMe'
    @user.username = mixed_case_username
    @user.save
    assert_equal mixed_case_username.downcase, 'username'
  end

  it 'is invalid when email not unique' do
    user = User.new(
      first_name: 'first_name', last_name: 'last_name', user_type: 'admin',
      password: 'password', username: 'username', email: 'test@email.com'
    )
    user.save
    duplicate_user = User.new(
      first_name: 'first_name', last_name: 'last_name', user_type: 'admin',
      password: 'password', username: 'username2', email: 'test@email.com'
    )
    expect(duplicate_user).to_not be_valid
  end

  it 'has and belongs to many groups' do
    association = User.reflect_on_association(:groups)
    assert_same association.macro, :has_and_belongs_to_many
  end

  it 'has and belongs to many notifications' do
    association = User.reflect_on_association(:notifications)
    assert_same association.macro, :has_and_belongs_to_many
  end

  it { should validate_presence_of :username }
  it { should validate_length_of(:username).is_at_most(50) }
  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of :first_name }
  it { should validate_length_of(:first_name).is_at_most(50) }
  it { should validate_presence_of :last_name }
  it { should validate_length_of(:last_name).is_at_most(50) }
  it { should validate_presence_of :user_type }
end
