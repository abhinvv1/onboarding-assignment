# frozen_string_literal: true
require_relative 'constants'

# The Player class represents a player in the Greed game.
# It keeps track of the player's name, score, and whether they are "in the game"
# (have scored at least 300 points in a single turn).
class Player
  include Constants

  attr_reader :score, :name
  attr_accessor :in_game

  def initialize(name)
    validate_name(name)
    @name = name
    @score = 0
    @in_game = false
  end

  # Adds points to the player's score and updates their "in the game" status
  # if they've reached or exceeded the minimum score to enter.
  # @param points [Integer] The number of points to add to the player's score.
  # @raise [ArgumentError] If points is not a non-negative integer.
  def add_score(points)
    validate_points(points)

    @score += points
    @in_game = true if @score >= MINIMUM_SCORE_TO_ENTER
  end

  private

  def validate_name(name)
    raise ArgumentError, "Name must be a non-empty string" unless name.is_a?(String) && !name.strip.empty?
  end

  def validate_points(points)
    raise ArgumentError, "Points must be a non-negative integer" unless points.is_a?(Integer) && points >= 0
  end
end
