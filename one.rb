$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'wordnik'

class RubyDictionary
  attr_accessor :word
  def initialize(word = "default")
    @word = word
  end

  def definition
    puts "getting #{word} from wordnik"
    puts "definition of #{word} is ...!"
  end

  def synonyms
    puts "getting Synonym for #{word} from wordnik"
    puts "synonym of #{word} is ...!"
  end

  def antonyms
    puts "getting antonyms for #{word} from wordnik"
    puts "antonyms of #{word} is ...!"
  end

  def examples
    puts "getting examples #{word} from wordnik"
    puts "examples of #{word} is ...!"
  end

  def allInfo(word = @word)
    @word = word
    puts "getting allInfo #{word} from wordnik"
    puts "allInfo of #{word} is ...!"
    end

  def wordOfDay
    puts "getting word of day"
    puts "word of day is .."
  end

  def wordNotFound
    puts "getting Similar words for #{word} from wordnik"
    puts "similar words of #{word} is ...!"
  end

  def game
    puts "getting Similar words for #{word} from wordnik"
    puts "similar words of #{word} is ...!"
  end

end


wordnik = Wordnik.new
definitions = wordnik.define('simple')

puts "got from wordnik #{definitions}"

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
when nil
  dict.wordOfDay()
else
  dict.allInfo(ARGV[0])
end
