# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../game'
require_relative '../die'
require_relative '../player'
require_relative '../score_calculator'

class TestGame < Minitest::Test
  def setup
    @game = Game.new(2)
  end

  def test_game_initialization
    assert_equal 2, @game.instance_variable_get(:@players).size
    assert_equal 5, @game.instance_variable_get(:@dice).size
    assert_equal 0, @game.instance_variable_get(:@current_player)
    assert_equal false, @game.instance_variable_get(:@final_round)
    assert_equal 1, @game.instance_variable_get(:@turn_number)
  end

end