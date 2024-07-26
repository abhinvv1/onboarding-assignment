# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../score_calculator'
require_relative '../die'

class TestDie < Die
  def initialize(value)
    super()
    @value = value
  end
end

class TestScoreCalculator < Minitest::Test
  def test_score_of_an_empty_list_is_zero
    assert_equal [0, 0], ScoreCalculator.calculate([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    dice = [TestDie.new(5)]
    assert_equal [50, 1], ScoreCalculator.calculate(dice)
  end

  def test_score_of_a_single_roll_of_1_is_100
    dice = [TestDie.new(1)]
    assert_equal [100, 1], ScoreCalculator.calculate(dice)
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    dice = [TestDie.new(1), TestDie.new(5), TestDie.new(5), TestDie.new(1)]
    assert_equal [300, 4], ScoreCalculator.calculate(dice)
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    dice = [TestDie.new(2), TestDie.new(3), TestDie.new(4), TestDie.new(6)]
    assert_equal [0, 0], ScoreCalculator.calculate(dice)
  end

  def test_score_of_a_triple_1_is_1000
    dice = [TestDie.new(1), TestDie.new(1), TestDie.new(1)]
    assert_equal [1000, 3], ScoreCalculator.calculate(dice)
  end

  def test_score_of_other_triples_is_100x
    assert_equal [200, 3], ScoreCalculator.calculate([TestDie.new(2), TestDie.new(2), TestDie.new(2)])
    assert_equal [300, 3], ScoreCalculator.calculate([TestDie.new(3), TestDie.new(3), TestDie.new(3)])
    assert_equal [400, 3], ScoreCalculator.calculate([TestDie.new(4), TestDie.new(4), TestDie.new(4)])
    assert_equal [500, 3], ScoreCalculator.calculate([TestDie.new(5), TestDie.new(5), TestDie.new(5)])
    assert_equal [600, 3], ScoreCalculator.calculate([TestDie.new(6), TestDie.new(6), TestDie.new(6)])
  end

  def test_score_of_mixed_is_sum
    assert_equal [250, 4], ScoreCalculator.calculate([TestDie.new(2), TestDie.new(5), TestDie.new(2), TestDie.new(2), TestDie.new(3)])
    assert_equal [550, 4], ScoreCalculator.calculate([TestDie.new(5), TestDie.new(5), TestDie.new(5), TestDie.new(5)])
    assert_equal [1100, 4], ScoreCalculator.calculate([TestDie.new(1), TestDie.new(1), TestDie.new(1), TestDie.new(1)])
    assert_equal [1200, 5], ScoreCalculator.calculate([TestDie.new(1), TestDie.new(1), TestDie.new(1), TestDie.new(1), TestDie.new(1)])
    assert_equal [1150, 5], ScoreCalculator.calculate([TestDie.new(1), TestDie.new(1), TestDie.new(1), TestDie.new(5), TestDie.new(1)])
  end
end
