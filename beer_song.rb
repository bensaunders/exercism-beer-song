# frozen_string_literal: true

# A solution to the Beer Song exercise from Exercism
class BeerSong
  def self.recite(bottles, verses)
    bottles.downto(bottles - (verses - 1)).reduce([]) do |memo, verse_bottles|
      memo << verse(verse_bottles)
    end.join("\n")
  end

  def self.verse(bottles)
    case bottles
    when 0
      LastVerse.new(bottles).sing
    when 1
      SecondToLastVerse.new(bottles).sing
    when 2
      ThirdToLastVerse.new(bottles).sing
    else
      Verse.new(bottles).sing
    end
  end

  # Describes a verse of the beer song
  class Verse
    def initialize(number)
      @number = number
    end

    def sing
      <<~TEXT
        #{initial_quantity} #{initial_container} of beer on the wall, #{initial_quantity.downcase} #{initial_container} of beer.
        #{action}, #{resulting_quantity.downcase} #{resulting_container} of beer on the wall.
      TEXT
    end

    private

    attr_reader :number

    def initial_quantity
      number.to_s
    end

    def initial_container
      'bottles'
    end

    def action
      'Take one down and pass it around'
    end

    def resulting_quantity
      (number - 1).to_s
    end

    def resulting_container
      'bottles'
    end
  end

  # A verse that's suitable for when there are two bottles left
  class ThirdToLastVerse < Verse
    def resulting_container
      'bottle'
    end
  end

  # A verse that's suitable for when there is one bottle left
  class SecondToLastVerse < Verse
    def initial_container
      'bottle'
    end

    def action
      'Take it down and pass it around'
    end

    def resulting_quantity
      'No more'
    end
  end

  # A verse that's suitable for when there are no bottles left
  class LastVerse < Verse
    def initial_quantity
      'No more'
    end

    def action
      'Go to the store and buy some more'
    end

    def resulting_quantity
      '99'
    end
  end
end
