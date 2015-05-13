# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ipgeobase/version"

Gem::Specification.new do |s|
  s.name        = "glebtv_ipgeobase"
  s.version     = Ipgeobase::VERSION
  s.authors     = ["glebtv", "Avramov Vsevolod"]
  s.email       = ["glebtv@gmail.com", "gsevka@gmail.com"]
  s.homepage    = "http://github.com/glebtv/ipgeobase"
  s.summary     = "upload archive from IPGeoBase.ru to your project"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 2.0.0'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
end
