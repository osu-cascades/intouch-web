class Group < ApplicationRecord

  has_and_belongs_to_many :users, dependent: :destroy
  has_and_belongs_to_many :notifications

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }

end
