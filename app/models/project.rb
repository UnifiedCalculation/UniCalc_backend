class Project < ApplicationRecord
  belongs_to :customer
  belongs_to :company

  has_many :entries
end
