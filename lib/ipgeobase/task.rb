# coding: utf-8

module Ipgeobase
  module Task
    def self.obtain_content_by_filename(filename)
      if defined? Rails
        file = ::Rails.root.join('tmp', filename)
      else
        file = File.join(File.dirname(__FILE__), '..', '..', 'tmp', filename)
      end
      unless File.exist? file
        puts 'downloading database'
        url = 'http://ipgeobase.ru/files/db/Main/geo_files.tar.gz'
        Kernel.system("curl #{url} | tar -xzOf - #{filename} | iconv -f cp1251 -t utf-8 > #{file}")
      end
      File.read(file)
    end
  end
end
