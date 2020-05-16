class Company < ApplicationRecord
    has_many :articles
    has_many :employees
end
