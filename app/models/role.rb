class Role < ApplicationRecord

  has_many :users, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }

end
