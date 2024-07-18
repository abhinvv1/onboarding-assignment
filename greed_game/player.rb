# frozen_string_literal: true

class Player
  attr_reader :score, :name
  attr_accessor :in_game

  def initialize(name)
    @name = name
    @score = 0
    @in_game = false
  end

  def add_score(points)
    @score += points
    @in_game = true if @score >= 300
  end
end