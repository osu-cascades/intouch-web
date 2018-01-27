class Notification < ApplicationRecord
  has_many :users 

  validates :title, presence: true
  validates :content, presence: true

end
