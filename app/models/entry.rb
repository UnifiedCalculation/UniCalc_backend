class Entry < ApplicationRecord
  belongs_to :form

  has_many :articels_entries
  has_many :articels, through: :articels_entries
end
