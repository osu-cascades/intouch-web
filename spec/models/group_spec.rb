require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    @group = Group.new(name: 'Group')
  end

  it 'is valid with name set' do
    expect(@group).to be_valid
  end

  it 'is invalid when name is empty' do
    @group.name = '    '
    expect(@group).to_not be_valid
  end

  it 'is invalid when name is not present' do
    @group.name = nil
    expect(@group).to_not be_valid
  end

  it 'is invalid when name is longer than 100 characters' do
    @group.name = 'a' * 101
    expect(@group).to_not be_valid
  end

  it 'is invalid when name is not unique' do
    @group.save
    duplicate_group = @group.dup
    expect(duplicate_group).to_not be_valid
  end

  it 'is invalid when the only thing unique about name is case' do
    @group.save
    duplicate_group = @group.dup
    duplicate_group.name = @group.name.upcase
    expect(duplicate_group).to_not be_valid
  end

  it 'has and belongs to many users' do
    association = Group.reflect_on_association(:users)
    assert_same association.macro, :has_and_belongs_to_many
  end

  it 'has and belongs to many notifications' do
    association = Group.reflect_on_association(:notifications)
    assert_same association.macro, :has_and_belongs_to_many
  end

  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_most(100) }
  it { should validate_uniqueness_of(:name).case_insensitive }
end
