class Notification < ApplicationRecord
	has_and_belongs_to_many :users


	 validates :title, presence: true
	 validates :first_name, presence: true
	 validates :content, presence: true
end
