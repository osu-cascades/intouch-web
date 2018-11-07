require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'is valid with name set' do
    expect(Group.new(name: 'Group')).to be_valid
  end

  it 'is invalid when name is empty' do
    expect(Group.new(name: '   ')).to_not be_valid
  end

  it 'is invalid when name is not present' do
    expect(Group.new(name: nil)).to_not be_valid
  end

  it 'is invalid when name is longer than 100 characters' do
    expect(Group.new(name: 'a' * 101)).to_not be_valid
  end

  it 'is invalid when name is not unique' do
    group = Group.new(name: 'Group')
    group.save
    duplicate_group = group.dup
    expect(duplicate_group).to_not be_valid
  end

  it 'names are not case sensitive' do
    group = Group.new(name: 'Group')
    group.save
    duplicate_group = group.dup
    duplicate_group.name = group.name.upcase
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
  it { should validate_length_of :name }
  it { should validate_uniqueness_of(:name).case_insensitive }
end
