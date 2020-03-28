class Npk < ApplicationRecord
  belongs_to :npk, optional: true
  has_many :npks
  has_many :articels

  def parent
    npk
  end

  def children
    npks
  end
end
