class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_and_belongs_to_many :groups  
	has_and_belongs_to_many :notifications
  
	

	# validates :first_name, presence: true, length: { maximum: 50 }
	# validates :last_name, presence: true, length: { maximum: 50 }
	# validates :user_type, presence: true, inclusion: { in: %w(admin client staff) }
	# validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
	# validates :password, presence: true, length: { minimum: 6, maximum: 50 }, allow_nil: true

	

	

end
