class Notification < ApplicationRecord
  has_many :users 
  has_many :groups 

  validates :title, presence: true
  validates :content, presence: true

end
