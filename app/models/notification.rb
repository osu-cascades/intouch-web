class Notification < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :groups
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :date, presence: true
end
