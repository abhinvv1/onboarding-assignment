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

  def test_roll_dice
    @game.send(:roll_dice, 3)
    rolled_dice = @game.instance_variable_get(:@dice).take(3)
    assert rolled_dice.all? { |die| die.value.between?(1, 6) }
  end

  def test_unroll_dice
    @game.send(:roll_dice, 5)
    @game.send(:unroll_dice, 3)
    unrolled_dice = @game.instance_variable_get(:@dice).take(3)
    assert unrolled_dice.all? { |die| die.value.nil? }
  end

  def test_next_player
    initial_player = @game.instance_variable_get(:@current_player)
    @game.send(:next_player)
    next_player = @game.instance_variable_get(:@current_player)
    assert_equal (initial_player + 1) % 2, next_player
  end

  def test_check_final_round
    player = @game.instance_variable_get(:@players).first
    player.instance_variable_set(:@score, 2999)
    @game.send(:check_final_round)
    assert_equal false, @game.instance_variable_get(:@final_round)

    player.instance_variable_set(:@score, 3000)
    @game.send(:check_final_round)
    assert_equal true, @game.instance_variable_get(:@final_round)
  end

  def test_validate_num_players
    assert_raises(ArgumentError) { @game.send(:validate_num_players, 0) }
    assert_raises(ArgumentError) { @game.send(:validate_num_players, -1) }
    assert_nil @game.send(:validate_num_players, 5)
  end
end
