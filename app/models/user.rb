class User < ApplicationRecord
	# overrides rails attributes, remove
	# attr_accessor :firstName, :lastName, :userType, :username, :password
	validates :firstName, presence: true, length: { maximum: 50 }
	validates :lastName, presence: true, length: { maximum: 50 }
	validates :userType, presence: true, length: { maximum: 50 }
	validates :username, presence: true, length: { maximum: 50 }
	validates :password, presence: true, length: { maximum: 50 }
end


