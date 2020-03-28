class User < ApplicationRecord
  has_secure_password

  has_one :employee
  has_one :customer

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{firstname} #{lastname}"
  end
end
