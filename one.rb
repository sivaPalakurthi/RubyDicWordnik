require 'rubygems'
require 'json'

Api_key = '557bea420b5c3daf4d0030a71cc0817242db37d2bc14774a3'
%w(rubygems wordnik).each {|lib| require lib}
Wordnik.configure do |config|
  config.api_key = Api_key
end

class RubyDictionary
  attr_accessor :word
  def initialize(word = "default")
    @word = word
  end

  def definition(limit = 3)
    parsed =  Wordnik.word.get_definitions(@word, :limit => limit)
    parsed.each do |res|
      tempWord = res['text']
      puts "  Def. :   #{tempWord}"
    end
  end

  def synonyms(limit = 3, print = true)
    parsed =  Wordnik.word.get_related(@word, :limit => limit, :type => 'synonym')
    parsed.each do |res|
      tempWord = res['words']
      if print == true
        puts " Synonyms : #{tempWord}"
      end
      return tempWord
    end
  end

  def antonyms(limit = 3)
    parsed =  Wordnik.word.get_related_words(@word, :limit => limit, :useCanonical => 'true', :relationshipTypes => 'antonym')
    parsed.each do |res|
      tempWord = res['words']
      puts " Anotonym : #{tempWord}"
    end
  end

  def examples(limit = 3)
    parsed = Wordnik.word.get_examples(@word, :limit => limit, :skip => 10)

    unless parsed['examples'].nil?
      parsed['examples'].each do |res|
        puts " Example:  #{res['text']}"
      end
    end
  end

  def allInfo(word = @word)
    @word = word
    definition()
    synonyms()
    antonyms()
    examples()
  end

  def wordOfDay
    todaysDate = Time.now.strftime("%Y-%m-%d")
    parsed = Wordnik.words.get_word_of_the_day(:date => todaysDate)
    @word = parsed['word']
    puts "Word of Day #{parsed['word']}"
  end

  def wordNotFound
    parsed = Wordnik.words.search_words(:query => 'si', :includePartOfSpeech => 'adjective', :excludePartOfSpeech => 'noun', :min_length => 3, :max_length => 20)

#    parsed['searchResults'].each do |res|
#      count = res['count']
#      tempWord = res['word']
#      if count > 0
#        puts "#{tempWord}"
#      end
#    end
  end

  def removeHintsFromAnswers
    @hintAnswers.each do |hint|
      hint.each do |hin|
        @listAnswers.each do |answer|
          if answer == hin
            @listAnswers.delete_at(@listAnswers.index(answer))
          end
        end
      end
    end
  end

  def game
    parsed = Wordnik.words.get_random_word(:hasDictionaryDef => 'true')
    @word = parsed['word']
    index = 1
    @hintAnswers = []
    puts " Guess the word "
    definition(index)
    @hintAnswers.push(synonyms(2))
    @listAnswers = synonyms(50, false)
    @listAnswers.push(word)
    removeHintsFromAnswers()
    #    puts @listAnswers
    until false do
      givenAnswer=$stdin.gets.chomp.downcase
      puts "#{givenAnswer}"
      @listAnswers.each do |answer|
        if answer == givenAnswer
          return
        end
      end
      puts 'Enter 1. Try Again   2. Hint    3. quit'
      choice = $stdin.gets.chomp
      if choice == '3'
        allInfo()
        return
      end
      if choice == '2'
        index = index + 1
        @hintAnswers.push(synonyms(index))
        removeHintsFromAnswers()
        antonyms(index - 1)
        definition(index -2)
      end
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
