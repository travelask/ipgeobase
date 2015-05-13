# coding: utf-8

require "ipgeobase/task"

namespace :ipgeobase do
  desc "Update cities and regions. Downloads file if it's not present in tmp/cities.txt"
  task :cities => :environment do
    puts 'updating cities'
    russia = Ipgeobase::Country.find_or_create_by(name: 'Россия', code: 'RU')
    ukraine = Ipgeobase::Country.find_or_create_by(name: 'Украина', code: 'UA')
    content = Ipgeobase::Task.obtain_content_by_filename('cities.txt')
    content.each_line do |c|
      options = c.split("\t")
      country = if options[3].include? "Украина"
                  ukraine
                else
                  russia
                end
      city = Ipgeobase::City.find_or_initialize_by(id: options[0])
      city.assign_attributes(city: options[1], region: options[2], district: options[3], lat: options[4], lon: options[5], country: country)
      city.save!
    end
  end

  desc "Update geo ips. Downloads file if it's not present in tmp/cidr_optim.txt"
  task :ips => :environment do
    puts 'updating ips'
    content = Ipgeobase::Task.obtain_content_by_filename('cidr_optim.txt')
    Ipgeobase::Ip.delete_all
    content.each_line do |c|
      options = c.split("\t")
      next if options.last.to_i.zero?
      city = Ipgeobase::City.where(id: options.last.strip.to_i).first
      if city.nil?
        p "No city"
        p options
        next
      end
      Ipgeobase::Ip.create(:start_ip => options.first.to_i, :end_ip => options.second.to_i, city_id: city.id)
    end
  end
end
