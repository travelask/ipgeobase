module Ipgeobase
  class Country < ActiveRecord::Base
    self.table_name = "ipgeobase_countries"
    has_many :cities, class_name: 'Ipgeobase::City'
    validates_presence_of :name
  end
end
