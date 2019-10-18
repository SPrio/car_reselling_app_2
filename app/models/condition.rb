class Condition < ApplicationRecord
  validates :cost, presence: true
  validates :condition, presence: true
  
end
