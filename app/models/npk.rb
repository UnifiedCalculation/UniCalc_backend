class Npk < ApplicationRecord
  belongs_to :npk, optional: true
  has_many :npks

  def parent
    npk
  end

  def children
    npks
  end
end
