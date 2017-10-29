class User < ApplicationRecord
	# overrides rails attributes, remove
	# attr_accessor :firstName, :lastName, :userType, :username, :password
	validates :firstName, :lastName, :userType, :username, :password, presence: true
end


