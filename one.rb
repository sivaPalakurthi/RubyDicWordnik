class RubyDictionary
  attr_accessor :word
  # Create the object
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
    ends

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

dict = RubyDictionary.new(ARGV[1])
#ARGV[1] is null then goto allInfo //todo

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

