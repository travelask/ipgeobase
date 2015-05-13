require "ipgeobase/version"
require 'ipaddr'

if defined? Rails::Engine
  require 'ipgeobase/engine'
end

module Ipgeobase
  class << self
    def find_region_by_ip(user_ip)
      long = ip2long(user_ip)
      Ipgeobase::Ip.select( <<-SELECT ).where( "start_ip <= #{long}" ).order( 'start_ip DESC' ).first.try(:city)
        CASE WHEN #{long} <= end_ip
             THEN city_id
             ELSE NULL END AS city_id
      SELECT
    end

    def ip2long(ip)
      IPAddr.new(ip, Socket::AF_INET).to_i
    end
  end
end
