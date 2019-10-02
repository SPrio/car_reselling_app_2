class Model < ApplicationRecord
  belongs_to :brand
  validates :name, presence: true
  validates :brand_id, presence: true

end
