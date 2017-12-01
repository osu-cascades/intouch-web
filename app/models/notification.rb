class Notification < ApplicationRecord
  has_and_belongs_to_many :users 
  has_and_belongs_to_many :groups 

  belongs_to :group

  validates :title, presence: true
  validates :content, presence: true
  validates :group_id, presence: true
end
