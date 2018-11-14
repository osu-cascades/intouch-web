require 'rails_helper'

RSpec.describe Role, type: :model do
  before(:each) do
    @role = Role.new(name: 'Role')
  end

  it 'is valid when name is set' do
    expect(@role).to be_valid
  end

  it 'is invalid when name is blank' do
    @role.name = '    '
    expect(@role).to_not be_valid
  end

  it 'is invalid when name is longer than 100 characters' do
    @role.name = 'a' * 101
    expect(@role).to_not be_valid
  end

  it 'is invalid when name is not unique' do
    @role.save
    duplicate_role = @role.dup
    expect(duplicate_role).to_not be_valid
  end

  it 'is invalid when the only thing unique about name is case' do
    @role.save
    duplicate_role = @role.dup
    duplicate_role.name = @role.name.upcase
    expect(duplicate_role).to_not be_valid
  end

  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_most(100) }
  it { should validate_uniqueness_of(:name).case_insensitive }
end
