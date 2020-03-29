class Articel < ApplicationRecord
  belongs_to :npk
  belongs_to :company

  has_many :entries, through: :articels_entries
end
