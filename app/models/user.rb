class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{firstname} #{lastname}"
  end
end
