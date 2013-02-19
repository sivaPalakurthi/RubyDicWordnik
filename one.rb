require 'rubygems'
require 'json'

%w(rubygems wordnik).each {|lib| require lib}
Wordnik.configure do |config|
  config.api_key ='557bea420b5c3daf4d0030a71cc0817242db37d2bc14774a3'
end

class RubyDictionary
  attr_accessor :word
  def initialize(word = "default")
    @word = word
  end

  def definition
    parsed =  Wordnik.word.get_definitions(@word)
    parsed.each do |res|
      tempWord = res['text']
      puts "#{tempWord}"
    end
  end

  def synonyms
    #    return Wordnik.word.get_related(@word, :type => 'synonym')
    return "Synonym #{word}"
  end

  def antonyms
    #    return Wordnik.word.get_related(@word, :type => 'hypernym', :use_canonical => true)
    return "antonym #{word}"
  end

  def examples
    #return Wordnik.word.get_examples(@word, :limit => 10, :skip => 10)
    return "sample sentence with  #{word}"
  end

  def allInfo(word = @word)
    @word = word
    return "@all info #{word}"

  end

  def wordOfDay
    todaysDate = Time.now.strftime("%Y-%m-%d")
    puts "#{todaysDate}"
    #Wordnik.words.get_word_of_the_day(:date => todaysDate)
  end

  def wordNotFound
    parsed = Wordnik.words.search_words(:query => '*#{@word}*', :include_part_of_speech => 'verb', :min_length => 5, :max_length => 20)
    parsed['searchResults'].each do |res|
      count = res['count']
      tempWord = res['word']
      if count > 0
        puts "#{tempWord}"
      end
    end
  end

  def game
    puts "getting Similar words for #{word} from wordnik"
    puts "similar words of #{word} is ...!"
  end

end

dict = RubyDictionary.new(ARGV[1])

case ARGV[0]
when "def"
  dict.definition()
when "syn"
  dict.synonyms()
when "ant"
  dict.antonyms()
when "ex"
  dict.examples()
when "dict"
  dict.allInfo()
when "play"
  dict.game()
when 'not'
  dict.wordNotFound()
when nil
  dict.wordOfDay()
else
  dict.allInfo(ARGV[0])
end
