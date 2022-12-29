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
      initial_quantity = 'No more'
      initial_container = 'bottles'
      action = 'Go to the store and buy some more'
      resulting_quantity = 99
      resulting_container = 'bottles'
    when 2
      initial_quantity = '2'
      initial_container = 'bottles'
      action = 'Take one down and pass it around'
      resulting_quantity = 1
      resulting_container = 'bottle'
    when 1
      initial_quantity = '1'
      initial_container = 'bottle'
      action = 'Take it down and pass it around'
      resulting_quantity = 'no more'
      resulting_container = 'bottles'
    else
      initial_quantity = bottles.to_s
      initial_container = 'bottles'
      action = 'Take one down and pass it around'
      resulting_quantity = bottles - 1
      resulting_container = 'bottles'
    end
    <<~TEXT
      #{initial_quantity} #{initial_container} of beer on the wall, #{initial_quantity.downcase} #{initial_container} of beer.
      #{action}, #{resulting_quantity} #{resulting_container} of beer on the wall.
    TEXT
  end
end
