require 'elasticsearch/model'

class Car < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_many :appointments, dependent: :destroy  
  validates :year , presence: true, inclusion: { in: (Year.first.start..Year.first.end).to_a }
  validates :brand , presence: true, inclusion: { in: Brand.all.pluck(:name) }
  validates :model , presence: true, inclusion: { in: Model.all.pluck(:name) }
  validates :city , presence: true, inclusion: { in: City.all.pluck(:name) }
  validates :condition , presence: true, inclusion: { in: Condition.all.pluck(:condition) }
  validates :kilometer_range , presence: true, inclusion: { in: KilometerRange.all.pluck(:name) }
  validates :state , presence: true, inclusion: { in: State.all.pluck(:name) }
  validates :variant , presence: true, inclusion: { in: Variant.all.pluck(:name) }
  validates :user_id , presence: true


  def self.filtered_search(search, city, brand, model, registration_year, variant, registration_state, kilometer_driven)
  
  search_query =
    {
    query: {
            bool: {
                # must: {
                # "match": {
                #     status: "verified"
                # }
                #    multi_match: {
                #         query: search,
                #         fields: [:city, :brand, :model, :registration_year, :variant, :registration_state, :kilometer_driven]
                #       }
                #  }
                # filter: {
                #   bool: {
                #         must: {
                #             terms: { "status.raw" => "verified" }
                #           }
                #       }
                # }
                #}
        }
      }
    }
    

    filter_query = [{
                      term: { verified: true}
                    },
                    { bool: {
                        should: [{
                            # match: { status: "verified" }
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

    #search and filter
    
    #print "city array ",cities
    unless registration_state.blank?
      registration_state.each do |r_s|
        registration_state_filter = { match:{ state: r_s }}
        filter_query[1][:bool][:should] << registration_state_filter
      end
    end
    unless city.blank?
      city.each do |c|
        city_filter = { match:{ city: c}}
        filter_query[1][:bool][:should] << city_filter
      end
      end
    unless brand.blank?
      brand.each do |b|
        brand_filter = { match:{ brand: b }}
        filter_query[1][:bool][:should] << brand_filter
      end
      end
    unless model.blank? 
      model.each do |m|
        model_filter = { match:{ model: m }}
        filter_query[1][:bool][:should] << model_filter
      end
      end
    unless variant.blank?
      variant.each do |v|
        variant_filter = { match:{ variant: v }}
        filter_query[1][:bool][:should] << variant_filter 
      end
      end
    unless registration_year.blank?
      registration_year.each do |r_y|
        registration_year_filter = { match:{ year: r_y }}
        filter_query[1][:bool][:should] << registration_year_filter
      end
      end
    unless kilometer_driven.blank?
      kilometer_driven.each do |k_d|
        kilometer_driven_filter = { match:{ kilometer_range: k_d }}
        filter_query[1][:bool][:should] << kilometer_driven_filter
      end
      end

    #filter_query[:bool][:should] << { term: {verified: true}}

    #print "filter query ", filter_query

    # city_filter = { match:{ city: city}}
    # filter_query[:bool][:must] << city_filter unless city.blank?

    # brand_filter = { match:{ brand: brand }}
    # filter_query[:bool][:must] << brand_filter unless brand.blank?

    # model_filter = { match:{ model: model }}
    # filter_query[:bool][:must] << model_filter unless model.blank?

    # registration_year_filter = { match:{ registration_year: registration_year }}
    # filter_query[:bool][:must] << registration_year_filter unless registration_year.blank?

    # variant_filter = { match:{ variant: variant }}
    # filter_query[:bool][:must] << variant_filter unless variant.blank?

    # registration_state_filter = { match:{ registration_state: registration_state }}
    # filter_query[:bool][:must] << registration_state_filter unless registration_state.blank?

    # kilometer_driven_filter = { match:{ kilometer_driven: kilometer_driven }}
    # filter_query[:bool][:must] << kilometer_driven_filter unless kilometer_driven.blank?

    filter_query[1][:bool][:should].shift

    search_query[:query][:bool].store(:filter, filter_query)
    # unless ( city.blank? or brand.blank? or model.blank? or registration_year.blank? or variant.blank? or registration_state.blank? or kilometer_driven.blank? )

    #only filter

    #search_query[:query][:bool].store(:filter, filter_query) unless city.p?
    
    print "search query ", search_query

    @cars = self.search(
      search_query
    )

    # @cars = self.search({
    #       "query": {
    #         "bool": {
    #             "filter": {
                    
    #                         "term": { "verified": true }
                         
    #               }
    #           }
    #     }
    # }
    # )

    #   self.search({
    #       "query": {
    #         "bool": {
    #             "must": {
    #                "multi_match": {
    #                     "query": search,
    #                     "fields": [:city, :brand, :model, :registration_year, :variant, :registration_state, :kilometer_driven]
    #                   }
    #               },
    #             "filter": {
    #                 "bool": {
    #                     "must": {
    #                         "match": { :city => city }
    #                       }
    #                   }
    #               }
    #           }
    #     }
    
    # })
    

  end
end
