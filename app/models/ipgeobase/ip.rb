module Ipgeobase
  class Ip < ActiveRecord::Base
    self.table_name = "ipgeobase_ips"
    belongs_to :city, class_name: 'Ipgeobase::City'
    validates_presence_of :start_ip, :end_ip, :city_id
  end
end
