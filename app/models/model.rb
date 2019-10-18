class Model < ApplicationRecord
  belongs_to :brand
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :brand_id, presence: true

end
