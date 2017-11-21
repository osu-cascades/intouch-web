class Role < ApplicationRecord

  has_many :users

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }

end
