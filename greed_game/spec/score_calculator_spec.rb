# frozen_string_literal: true

require_relative '../score_calculator'
require_relative '../die'

# we create a TestDie using Die as parent class we need to do this because Die takes random
# but to test scores we need to have few fixed values to get fixed scores
class TestDie < Die
  def initialize(value)
    super()
    @value = value
  end
end

RSpec.describe ScoreCalculator do
  describe 'test for calculate' do
    it 'returns zero score for an empty list' do
      expect(ScoreCalculator.calculate([])).to eq([0, 0])
    end

    it 'scores 50 for a single roll of 5' do
      expect(ScoreCalculator.calculate([TestDie.new(5)])).to eq([50, 1])
    end

    it 'scores 100 for a single roll of 1' do
      expect(ScoreCalculator.calculate([TestDie.new(1)])).to eq([100, 1])
    end

    it 'sums the scores of multiple 1s and 5s' do
      dice = [TestDie.new(1), TestDie.new(5), TestDie.new(5), TestDie.new(1)]
      expect(ScoreCalculator.calculate(dice)).to eq([300, 4])
    end

    it 'scores zero for single 2s, 3s, 4s, and 6s' do
      dice = [TestDie.new(2), TestDie.new(3), TestDie.new(4), TestDie.new(6)]
      expect(ScoreCalculator.calculate(dice)).to eq([0, 0])
    end

    it 'scores 1000 for a triple 1' do
      dice = [TestDie.new(1), TestDie.new(1), TestDie.new(1)]
      expect(ScoreCalculator.calculate(dice)).to eq([1000, 3])
    end

    context 'when scoring other triples' do
      it 'scores 100x the die value' do
        {
          2 => 200,
          3 => 300,
          4 => 400,
          5 => 500,
          6 => 600
        }.each do |die_value, expected_score|
          dice = [TestDie.new(die_value)] * 3
          expect(ScoreCalculator.calculate(dice)).to eq([expected_score, 3])
        end
      end
    end

    context 'when scoring mixed rolls' do
      it 'sums the scores correctly' do
        test_cases = [
          { dice: [2, 5, 2, 2, 3], expected: [250, 4] },
          { dice: [5, 5, 5, 5], expected: [550, 4] },
          { dice: [1, 1, 1, 1], expected: [1100, 4] },
          { dice: [1, 1, 1, 1, 1], expected: [1200, 5] },
          { dice: [1, 1, 1, 5, 1], expected: [1150, 5] }
        ]

        test_cases.each do |test_case|
          dice = test_case[:dice].map { |value| TestDie.new(value) }
          expect(ScoreCalculator.calculate(dice)).to eq(test_case[:expected])
        end
      end
    end
  end
end
