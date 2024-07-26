# frozen_string_literal: true
require_relative 'constants'
# The ScoreCalculator class is responsible for calculating the score
# for a given set of dice rolls in the Greed game.

class ScoreCalculator
  # Calculates the score and number of scoring dice for a given set of dice.
  # @param dice [Array<Die>] The array of Die objects to calculate the score for.
  # @return [Array<Integer>] An array containing the score and number of scoring dice.
  # @raise [ArgumentError] If the input is not an array or contains non-Die objects.

  def self.calculate(dice)
    include Constants
    begin
      validate_input(dice)

      counts = dice.map(&:value).tally
      score = 0
      scoring_dice = 0

      DIE_ARRAY.each do |num|
        if counts[num] && counts[num] >= 3
          score += (num == 1 ? TRIPLE_ONE_SCORE : num * TRIPLE_SCORE)
          scoring_dice += 3
          counts[num] -= 3
        end
      end

      # Check for individual 1s and 5s
      if counts[1]
        score += counts[1] * SINGLE_ONE_SCORE
        scoring_dice += counts[1]
      end
      if counts[5]
        score += counts[5] * SINGLE_FIVE_SCORE
        scoring_dice += counts[5]
      end

      [score, scoring_dice]
    rescue StandardError => e
      puts "An error occurred while calculating the score: #{e.message}"
      [0, 0]
    end
  end

  private

  def self.validate_input(dice)
    raise ArgumentError, "Input must be an array" unless dice.is_a?(Array)
    raise ArgumentError, "All elements must be Die objects" unless dice.all? { |die| die.is_a?(Die) }
    raise ArgumentError, "Die values must be between 1 and 6" unless dice.all? { |die| (1..6).include?(die.value) }
  end
end
