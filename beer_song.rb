# frozen_string_literal: true

# A solution to the Beer Song exercise from Exercism
class BeerSong
  MAX_CONTAINERS = 99

  def self.recite(containers, verses)
    song = []
    verses.times do
      song << verse(containers)
      containers -= 1
    end
    song.join("\n")
  end

  def self.verse(containers)
    situation = SubstanceSituationFactory.build(containers, MAX_CONTAINERS)
    Verse.new(situation).sing
  end

  # A factory for building the appropriate situation
  # for an amount of a substance
  module SubstanceSituationFactory
    def self.build(number, max)
      case number
      when 0
        NoSubstance.new(number, max)
      when 1
        OneSubstance.new(number, max)
      else
        SubstanceSituation.new(number, max)
      end
    end
  end

  # a class that describes the situation when there are a
  # certain number of containers of a substance available,
  # and you take some action to create a new situation
  class SubstanceSituation
    def initialize(number, max)
      @number = number
      @max = max
    end

    def description
      "#{number} bottles"
    end

    def action
      'Take one down and pass it around'
    end

    def next_situation
      SubstanceSituationFactory.build(number - 1, max)
    end

    private

    attr_reader :number, :max
  end

  # a class for when there's one container left
  class OneSubstance < SubstanceSituation
    def description
      '1 bottle'
    end

    def action
      'Take it down and pass it around'
    end
  end

  # a class for when there are no containers left
  class NoSubstance < SubstanceSituation
    def description
      'No more bottles'
    end

    def action
      'Go to the store and buy some more'
    end

    def next_situation
      SubstanceSituationFactory.build(max, max)
    end
  end

  # Describes a verse of a substance song
  class Verse
    def initialize(situation)
      @situation = situation
    end

    def sing
      <<~TEXT
        #{situation.description} of beer on the wall, #{situation.description.downcase} of beer.
        #{situation.action}, #{next_situation.description.downcase} of beer on the wall.
      TEXT
    end

    private

    def next_situation
      situation.next_situation
    end

    attr_reader :situation
  end
end
