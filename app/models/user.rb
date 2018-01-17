class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_and_belongs_to_many :groups  
	has_and_belongs_to_many :notifications
  
	# Per the instructions to be able to user username as key for authentication
  #https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-with-something-other-than-their-email-address
  # 

  def email_required?
    false
  end

  
  # use this instead of email_changed? for rails >= 5.1
  def will_save_change_to_email?
    false
  end

	# validates :first_name, presence: true, length: { maximum: 50 }
	# validates :last_name, presence: true, length: { maximum: 50 }
	# validates :user_type, presence: true, inclusion: { in: %w(admin client staff) }
	 validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
	# validates :password, presence: true, length: { minimum: 6, maximum: 50 }, allow_nil: true

	validates :email, uniqueness: true


	

end
