class Car < ApplicationRecord
  belongs_to :user
  validates :year , presence: true, inclusion: { in: (Year.first.start..Year.first.end).to_a }
  validates :brand , presence: true, inclusion: { in: Brand.all.pluck(:name) }
  validates :model , presence: true, inclusion: { in: Model.all.pluck(:name) }
  validates :city , presence: true, inclusion: { in: City.all.pluck(:name) }
  validates :condition , presence: true, inclusion: { in: Condition.all.pluck(:condition) }
  validates :kilometer_range , presence: true, inclusion: { in: KilometerRange.all.pluck(:name) }
  validates :state , presence: true, inclusion: { in: State.all.pluck(:name) }
  validates :variant , presence: true, inclusion: { in: Variant.all.pluck(:name) }
  validates :user_id , presence: true
end
