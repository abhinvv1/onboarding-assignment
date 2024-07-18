# frozen_string_literal: true

# The Die class represents a single six-sided die in the Greed game.
# It can be rolled to generate a random value between 1 and 6,
# and can also be unrolled (reset to nil) when needed.
class Die
  attr_reader :value

  def initialize
    @value = nil
  end

  # Rolls the die and sets its value to a random number between 1 and 6.
  def roll
    @value = rand(1..6)
  end

  # Resets the die's value to nil, representing an unrolled state.
  def unroll
    @value = nil
  end
end
