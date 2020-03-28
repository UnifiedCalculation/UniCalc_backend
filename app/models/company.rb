class Company < ApplicationRecord
    has_many :articels
    has_many :employees
end
