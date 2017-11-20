class Notification < ApplicationRecord
  has_and_belongs_to_many :users 
  has_and_belongs_to_many :groups 

  validates :title, presence: true
  validates :content, presence: true
end
