class BeerSong
  def self.recite(bottles, verses)
    bottles.downto(bottles-(verses-1)).reduce([]) do |memo, bottles|
      memo << verse(bottles)
    end.join("\n")
  end
  def self.verse(bottles)
    if bottles == 0
      <<~TEXT
        No more bottles of beer on the wall, no more bottles of beer.
        Go to the store and buy some more, 99 bottles of beer on the wall.
      TEXT
    elsif bottles == 2
      <<~TEXT
        2 bottles of beer on the wall, 2 bottles of beer.
        Take one down and pass it around, 1 bottle of beer on the wall.
      TEXT
    elsif bottles == 1
      <<~TEXT
        1 bottle of beer on the wall, 1 bottle of beer.
        Take it down and pass it around, no more bottles of beer on the wall.
      TEXT
    else
      <<~TEXT
        #{bottles} bottles of beer on the wall, #{bottles} bottles of beer.
        Take one down and pass it around, #{bottles-1} bottles of beer on the wall.
      TEXT
    end
  end
end