class User < ApplicationRecord
	# overrides rails attributes, remove
	# attr_accessor :firstName, :lastName, :userType, :username, :

	before_save { username.downcase! } 
	#self.username = self.username.downcase 

	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	validates :user_type, presence: true, length: { maximum: 50 }
	validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6, maximum: 50 }

	has_secure_password

end
