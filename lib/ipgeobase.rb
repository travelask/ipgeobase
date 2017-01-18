require "ipgeobase/version"
require 'ipaddr'
require "resolv"

if defined? Rails::Engine
  require 'ipgeobase/engine'
end

module Ipgeobase
  class << self
    def find_region_by_ip(user_ip)
      raise ArgumentError, "Must have a valid IPv4 or IPv6 addres" unless !!((user_ip =~ Resolv::IPv4::Regex) || (user_ip =~ Resolv::IPv6::Regex))
      long = ip2long(user_ip)
      Ipgeobase::Ip.select( <<-SELECT ).where( "start_ip <= #{long}" ).order( 'start_ip DESC' ).first.try(:city)
        CASE WHEN #{long} <= end_ip
             THEN city_id
             ELSE NULL END AS city_id
      SELECT
    end

    def ip2long(ip)
      IPAddr.new(ip).to_i
    end
  end
end
