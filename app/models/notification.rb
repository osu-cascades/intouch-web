class Notification < ApplicationRecord
	 validates :title, presence: true
	 validates :first_name, presence: true
	 validates :content, presence: true
end
