module Ipgeobase
  class Engine < ::Rails::Engine
    rake_tasks do
      load "ipgeobase/tasks.rake"
    end
  end
end
