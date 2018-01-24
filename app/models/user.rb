class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_and_belongs_to_many :groups  
	has_and_belongs_to_many :notifications
  
validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: true

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

end
