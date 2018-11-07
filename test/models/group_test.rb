require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    @group = Group.new(name: 'All Clients')
  end

  test 'group should be valid when name is present' do
    assert @group.valid?
  end

  test 'group should be invalid when name is empty' do
    @group.name = '    '
    assert_not @group.valid?
  end

  test 'group should be invalid when name is not present' do
    @group.name = nil
    assert_not @group.valid?
  end

  test 'name should not be longer than 100 characters' do
    @group.name = 'a' * 101
    assert_not @group.valid?
  end

  test 'name should be unique' do
    duplicate_group = @group.dup
    @group.save
    assert_not duplicate_group.valid?
  end

  test 'names are not case sensitive' do
    duplicate_group = @group.dup
    duplicate_group.name = @group.name.upcase
    @group.save
    assert_not duplicate_group.valid?
  end

  test 'has and belongs to many users' do
    association = Group.reflect_on_association(:users)
    assert_same association.macro, :has_and_belongs_to_many
  end

  test 'has and belongs to many notifications' do
    association = Group.reflect_on_association(:notifications)
    assert_same association.macro, :has_and_belongs_to_many
  end
end
