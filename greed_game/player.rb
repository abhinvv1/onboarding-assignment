# frozen_string_literal: true

# The Player class represents a player in the Greed game.
# It keeps track of the player's name, score, and whether they are "in the game"
# (have scored at least 300 points in a single turn).
class Player
  attr_reader :score, :name
  attr_accessor :in_game

  def initialize(name)
    @name = name
    @score = 0
    @in_game = false
  end

  # Adds points to the player's score and updates their "in the game" status
  # if they've reached or exceeded 300 points.
  def add_score(points)
    @score += points
    @in_game = true if @score >= 300
  end
end