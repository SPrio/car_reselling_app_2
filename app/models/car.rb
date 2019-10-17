require 'elasticsearch/model'

class Car < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_many :appointments, dependent: :destroy  
  validates :year , presence: true, inclusion: { in: (Year.last.start..Year.last.end).to_a } if Year.last
  validates :brand , presence: true, inclusion: { in: Brand.all.pluck(:name) }
  validates :model , presence: true, inclusion: { in: Model.all.pluck(:name) }
  validates :city , presence: true, inclusion: { in: City.all.pluck(:name) }
  validates :condition , presence: true, inclusion: { in: Condition.all.pluck(:condition) }
  validates :kilometer_range , presence: true, inclusion: { in: KilometerRange.all.pluck(:name) }
  validates :state , presence: true, inclusion: { in: State.all.pluck(:name) }
  validates :variant , presence: true, inclusion: { in: Variant.all.pluck(:name) }
  validates :user_id , presence: true


  def self.filtered_search(search, city, brand, model, registration_year, variant, registration_state, kilometer_driven)
  
  search_query = {
                  query: {
                      bool: {

                      }
                    }
                }
    

  filter_query = [{term: { verified: true }},
                  {term: { sold: false }},
                  { bool: {
                      should: [{
                          
                          # match: { :city => city }
                        }]
                    }
                    }]
                    
  #only search
  text_query= {
    multi_match: {
                  query: search,
                  fields: [:city, :brand, :model, :registration_year, :variant, :registration_state, :kilometer_driven]
                }
  }
  search_query[:query][:bool].store(:must, text_query) unless search.blank?

  unless registration_state.blank?
    registration_state.each do |r_s|
      registration_state_filter = { match:{ state: r_s }}
      filter_query[2][:bool][:should] << registration_state_filter
    end
  end
  unless city.blank?
    city.each do |c|
      city_filter = { match:{ city: c}}
      filter_query[2][:bool][:should] << city_filter
    end
    end
  unless brand.blank?
    brand.each do |b|
      brand_filter = { match:{ brand: b }}
      filter_query[2][:bool][:should] << brand_filter
    end
    end
  unless model.blank? 
    model.each do |m|
      model_filter = { match:{ model: m }}
      filter_query[2][:bool][:should] << model_filter
    end
    end
  unless variant.blank?
    variant.each do |v|
      variant_filter = { match:{ variant: v }}
      filter_query[2][:bool][:should] << variant_filter 
    end
    end
  unless registration_year.blank?
    registration_year.each do |r_y|
      registration_year_filter = { match:{ year: r_y }}
      filter_query[2][:bool][:should] << registration_year_filter
    end
    end
  unless kilometer_driven.blank?
    kilometer_driven.each do |k_d|
      kilometer_driven_filter = { match:{ kilometer_range: k_d }}
      filter_query[2][:bool][:should] << kilometer_driven_filter
    end
    end

  filter_query[2][:bool][:should].shift

  search_query[:query][:bool].store(:filter, filter_query)
  
  print "search query ", search_query

  @cars = self.search(
    search_query
  )
  end
end
