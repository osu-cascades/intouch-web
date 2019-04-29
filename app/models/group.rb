class Group < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :notifications
  has_and_belongs_to_many :events

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: {
    case_sensitive: false
  }
end
