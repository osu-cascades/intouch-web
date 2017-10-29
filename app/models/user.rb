class User < ApplicationRecord
	# overrides rails attributes, remove
	# attr_accessor :firstName, :lastName, :userType, :username, :

	before_save { username.downcase! } 
	#self.username = self.username.downcase 

	validates :firstName, presence: true, length: { maximum: 50 }
	validates :lastName, presence: true, length: { maximum: 50 }
	validates :userType, presence: true, length: { maximum: 50 }
	validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 14, maximum: 50 }
	# validates :password, presence: true, length: {  }

	has_secure_password

end


