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
    parsed =  Wordnik.word.get_related(@word, :type => 'synonym')
    parsed.each do |res|
      tempWord = res['words']
      puts "#{tempWord}"
      return tempWord
    end
  end

  def antonyms
    parsed =  Wordnik.word.get_related_words(@word, :useCanonical => 'true', :relationshipTypes => 'antonym')
    parsed.each do |res|
      tempWord = res['words']
      puts "#{tempWord}"
    end
  end

  def examples
    parsed = Wordnik.word.get_examples(@word, :limit => 10, :skip => 10)

    unless parsed['examples'].nil?
      parsed['examples'].each do |res|
        puts "#{res['text']}"
      end
    end
  end

  def allInfo(word = @word)
    @word = word
    puts " Definition : "
    definition()
    puts " Synonyms : "
    synonyms()
    puts " Antonyms : "
    antonyms()
    puts " Examples : "
    examples()
  end

  def wordOfDay
    todaysDate = Time.now.strftime("%Y-%m-%d")
    parsed = Wordnik.words.get_word_of_the_day(:date => todaysDate)
    @word = parsed['word']
    puts "Word of Day #{parsed['word']}"
  end

  def wordNotFound
    parsed = Wordnik.words.search_words(:query => '*#{@word}*',  :allowRegex => 'true', :includePartOfSpeech => 'adjective', :excludePartOfSpeech => 'noun', :min_length => 3, :max_length => 20)
    parsed['searchResults'].each do |res|
      count = res['count']
      tempWord = res['word']
      if count > 0
        puts "#{tempWord}"
      end
    end
  end

  def game
    parsed = Wordnik.words.get_random_word(:hasDictionaryDef => 'true')
    @word = parsed['word']
    puts "#{word}"
    syn = synonyms()
    name=$stdin.read
#    puts name
    if name == syn
      puts "correct"
    end
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
  dict.allInfo()
else
  dict.allInfo(ARGV[0])
end
