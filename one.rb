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

  def definition(limit = 3, relatedWords = false)
    parsed =  Wordnik.word.get_definitions(@word, :limit => limit)
    parsed.each do |res|
      tempWord = res['text']
      puts "$$ Def. :   #{tempWord}"
      return
    end
    if relatedWords == true
      puts "==>Word not Found"
      wordNotFound()
    end
  end

  def synonyms(limit = 3, print = true, relatedWords = false)
    parsed =  Wordnik.word.get_related(@word, :limit => limit, :type => 'synonym')
    parsed.each do |res|
      tempWord = res['words']
      if print == true
        puts "$$ Synonyms : #{tempWord}"
      end
      return tempWord
    end
    if relatedWords == true
      puts "==>Word not Found"
      wordNotFound()
    end

  end

  def antonyms(limit = 3, relatedWords = false)
    parsed =  Wordnik.word.get_related_words(@word, :limit => limit, :useCanonical => 'true', :relationshipTypes => 'antonym')
    parsed.each do |res|
      tempWord = res['words']
      puts "$$ Anotonym : #{tempWord}"
      return
    end
    if relatedWords == true
      puts "==>Word not Found"
      wordNotFound()
    end

  end

  def examples(limit = 3, relatedWords = false)
    parsed = Wordnik.word.get_examples(@word, :limit => limit, :skip => 10)
    found = false
    unless parsed['examples'].nil?
      parsed['examples'].each do |res|
        found = true
        puts "$$ Example:  #{res['text']}"
      end
    end
    if relatedWords == true && found == false
      puts "==>Word not Found"
      wordNotFound()
    end
  end

  def allInfo(word = @word)
    @word = word
    definition(3, true)
    synonyms()
    antonyms()
    examples()
  end

  def wordOfDay
    todaysDate = Time.now.strftime("%Y-%m-%d")
    parsed = Wordnik.words.get_word_of_the_day(:date => todaysDate)
    @word = parsed['word']
    puts "$$ Word of Day #{parsed['word']}"
  end

  def wordNotFound(limit = 3)
    var = "Value"
    reg = "*Value*"
    reg.gsub!( /#{var}/, @word )
    parsed = Wordnik.words.search_words(:query => reg, :allowRegex => 'true', :includePartOfSpeech => 'adjective', :excludePartOfSpeech => 'noun', :min_length => 3, :max_length => 20, :limit => limit)
    puts "$$ Related words: "
    parsed.each do |res|
      count = res['count']
      tempWord = res['wordstring']
      if count > 0
        puts "   #{tempWord}"
      end
    end
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
    @listAnswers = []
    puts "[Q] Guess the word "
    definition(index)
    hintAns = synonyms(index, true, false)
    if !hintAns.nil?
      @hintAnswers.push(hintAns)
      @listAnswers = synonyms(50, false, false)
    end
    @listAnswers.push(word)
    removeHintsFromAnswers()
    until false do
      puts "Enter the Guessed word ==>"
      givenAnswer=$stdin.gets.chomp.downcase
      @listAnswers.each do |answer|
        if answer == givenAnswer
          return
        end
      end
      puts "Incorrect Answer"
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
  dict.definition(3, true)
when "syn"
  dict.synonyms(3, true, true)
when "ant"
  dict.antonyms(3, true)
when "ex"
  dict.examples(3, true)
when "dict"
  dict.allInfo()
when "play"
  dict.game()
when nil
  dict.wordOfDay()
  dict.allInfo()
else
  dict.allInfo(ARGV[0])
end
