class Article < ApplicationRecord
  belongs_to :npk
  belongs_to :company

  has_many :articles_entries
  has_many :entries, through: :articles_entries
end
