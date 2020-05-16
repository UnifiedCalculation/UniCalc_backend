class Entry < ApplicationRecord
  belongs_to :form

  has_many :articles_entries
  has_many :articles, through: :articles_entries
end
