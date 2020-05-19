class Form < ApplicationRecord
  belongs_to :project
  belongs_to :employee

  belongs_to :copied_from, class_name: "Form", optional: true
  has_one :form

  has_many :entries, dependent: :destroy
end
