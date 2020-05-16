class Form < ApplicationRecord
  belongs_to :project
  belongs_to :employee

  has_many :entries
end
