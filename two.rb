%w(rubygems wordnik).each {|lib| require lib}

Wordnik.configure do |config|
  config.api_key = '557bea420b5c3daf4d0030a71cc0817242db37d2bc14774a3'
end