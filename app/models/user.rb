class User < ApplicationRecord
  has_secure_password

  has_one :employee
  has_one :customer
  has_one :company, through: :employee

  has_many :roles_users
  has_many :roles, through: :roles_users

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{firstname} #{lastname}"
  end
end
