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
    begin @value = rand(1..6)
      validate_value
      @value
    rescue StandardError => e
      puts "Error rolling die: #{e.message}"
      @value = nil
    end
  end

  def unroll
    @value = nil
  end

  def rolled?
    !@value.nil?
  end

  private

  def validate_value
    unless @value.is_a?(Integer) && @value.between?(1, 6)
      raise StandardError, "Invalid die value: #{@value}"
    end
  end
end
