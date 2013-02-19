%w(rubygems wordnik).each {|lib| require lib 

  puts "#{lib}"
}

Wordnik.configure do |config|
  puts "1"
    config.api_key = '557bea420b5c3daf4d0030a71cc0817242db37d2bc14774a3'
end

# Definitions
Wordnik.word.get_definitions('hysterical')