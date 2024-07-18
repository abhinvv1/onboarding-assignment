# frozen_string_literal: true

# score_calculator.rb
# The ScoreCalculator class is responsible for calculating the score
# for a given set of dice rolls in the Greed game.

class ScoreCalculator
  # Calculates the score and number of scoring dice for a given set of dice.
  # @param dice [Array<Die>] The array of Die objects to calculate the score for.
  # @return [Array<Integer>] An array containing the score and number of scoring dice.

  def self.calculate(dice)
    counts = dice.map(&:value).tally
    score = 0
    scoring_dice = 0

    [1, 2, 3, 4, 5, 6].each do |num|
      if counts[num] && counts[num] >= 3
        score += (num == 1 ? 1000 : num * 100)
        scoring_dice += 3
        counts[num] -= 3
      end
    end

    # Check for individual 1s and 5s
    if counts[1]
      score += counts[1] * 100
      scoring_dice += counts[1]
    end
    if counts[5]
      score += counts[5] * 50
      scoring_dice += counts[5]
    end

    [score, scoring_dice]
  end
end
