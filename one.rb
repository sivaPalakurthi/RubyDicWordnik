require 'rubygems'
require 'json'

class RubyDictionary
  attr_accessor :word
  def initialize(word = "default")
    @word = word
  end

  def definition
    #    return Wordnik.word.get_definitions(@word)
    string = '[
      {
        "textProns": [

        ],
        "sourceDictionary": "ahd-legacy",
        "exampleUses": [

        ],
        "relatedWords": [

        ],
        "labels": [

        ],
        "citations": [

        ],
        "word": "response",
        "text": "The act of responding.",
        "sequence": "0",
        "score": 0.0,
        "partOfSpeech": "noun",
        "attributionText": "from The American Heritage Dictionary of the English Language, 4th Edition"
      },
      {
        "textProns": [

        ],
        "sourceDictionary": "ahd-legacy",
        "exampleUses": [

        ],
        "relatedWords": [

        ],
        "labels": [

        ],
        "citations": [

        ],
        "word": "response",
        "text": "A reply or an answer.",
        "sequence": "1",
        "score": 0.0,
        "partOfSpeech": "noun",
        "attributionText": "from The American Heritage Dictionary of the English Language, 4th Edition"
      },
      {
        "textProns": [

        ],
        "sourceDictionary": "ahd-legacy",
        "exampleUses": [

        ],
        "relatedWords": [

        ],
        "labels": [

        ],
        "citations": [

        ],
        "word": "response",
        "text": "A reaction, as that of an organism or a mechanism, to a specific stimulus.",
        "sequence": "2",
        "score": 0.0,
        "partOfSpeech": "noun",
        "attributionText": "from The American Heritage Dictionary of the English Language, 4th Edition"
      },
      {
        "textProns": [

        ],
        "sourceDictionary": "ahd-legacy",
        "exampleUses": [

        ],
        "relatedWords": [

        ],
        "labels": [

        ],
        "citations": [

        ],
        "word": "response",
        "text": "Ecclesiastical   Something that is spoken or sung by a congregation or choir in answer to the officiating minister or priest.",
        "sequence": "3",
        "score": 0.0,
        "partOfSpeech": "noun",
        "attributionText": "from The American Heritage Dictionary of the English Language, 4th Edition"
      },
      {
        "textProns": [

        ],
        "sourceDictionary": "ahd-legacy",
        "exampleUses": [

        ],
        "relatedWords": [

        ],
        "labels": [

        ],
        "citations": [

        ],
        "word": "response",
        "text": "A responsory.",
        "sequence": "4",
        "score": 0.0,
        "partOfSpeech": "noun",
        "attributionText": "from The American Heritage Dictionary of the English Language, 4th Edition"
      }
    ]'
    parsed = JSON.parse(string)
    parsed.each do |res|
      tempWord = res['text']
      puts "#{tempWord}"
    end

    return "definition of #{word}"
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

    string = '{
      "totalResults": 36,
      "searchResults": [
        {
          "lexicality": 0.0,
          "count": 114,
          "word": "simpl"
        },
        {
          "lexicality": 0.0,
          "count": 1089104,
          "word": "simply"
        },
        {
          "lexicality": 0.0,
          "count": 945721,
          "word": "simple"
        },
        {
          "lexicality": 0.0,
          "count": 69170,
          "word": "simplicity"
        },
        {
          "lexicality": 0.0,
          "count": 43488,
          "word": "simpler"
        },
        {
          "lexicality": 0.0,
          "count": 32648,
          "word": "simplest"
        },
        {
          "lexicality": 0.0,
          "count": 28044,
          "word": "simplify"
        },
        {
          "lexicality": 0.0,
          "count": 21911,
          "word": "simplified"
        },
        {
          "lexicality": 0.0,
          "count": 19295,
          "word": "simplistic"
        },
        {
          "lexicality": 0.0,
          "count": 8489,
          "word": "simplifies"
        },
        {
          "lexicality": 0.0,
          "count": 8073,
          "word": "simplifying"
        }
      ]
    }'
    parsed = JSON.parse(string)
    parsed['searchResults'].each do |res|
      count = res['count']
      tempWord = res['word']
      if count > 0
        puts "#{tempWord}"
      end
    end

    return 'similar word'
    #    return Wordnik.words.search_words(@word, :allowRegex => 'false', :caseSensitive => 'true', :skip => 0, :limit => 10)
    # check if count !=0 print
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
