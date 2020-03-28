class Offer < ApplicationRecord
  belongs_to :project

  has_many :entries
end
