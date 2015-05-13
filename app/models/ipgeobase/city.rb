module Ipgeobase
  class City < ActiveRecord::Base
    self.table_name = "ipgeobase_cities"
    belongs_to :country, class_name: 'Ipgeobase::Country'
    validates_presence_of :city, :country
  end
end
