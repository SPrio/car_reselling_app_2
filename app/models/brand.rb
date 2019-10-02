class Brand < ApplicationRecord
  has_many :brands
  validates :name, presence: true
end
