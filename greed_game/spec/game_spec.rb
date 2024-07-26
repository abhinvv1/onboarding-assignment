# frozen_string_literal: true

require 'spec_helper'
require_relative '../game'
require_relative '../die'
require_relative '../player'
require_relative '../score_calculator'

RSpec.describe Game do
  let(:game) { Game.new(2) }

  describe '#initialize' do
    it 'initializes the game correctly' do
      expect(game.instance_variable_get(:@players).size).to eq(2)
      expect(game.instance_variable_get(:@dice).size).to eq(5)
      expect(game.instance_variable_get(:@current_player)).to eq(0)
      expect(game.instance_variable_get(:@final_round)).to be false
      expect(game.instance_variable_get(:@turn_number)).to eq(1)
    end
  end

  describe '#roll_dice' do
    it 'rolls the specified number of dice' do
      game.send(:roll_dice, 3)
      rolled_dice = game.instance_variable_get(:@dice).take(3)
      expect(rolled_dice).to all(satisfy { |die| die.value.between?(1, 6) })
    end
  end

  describe '#unroll_dice' do
    it 'unrolls the specified number of dice' do
      game.send(:roll_dice, 5)
      game.send(:unroll_dice, 3)
      unrolled_dice = game.instance_variable_get(:@dice).take(3)
      expect(unrolled_dice).to all(satisfy { |die| die.value.nil? })
    end
  end

  describe '#next_player' do
    it 'moves to the next player' do
      initial_player = game.instance_variable_get(:@current_player)
      game.send(:next_player)
      next_player = game.instance_variable_get(:@current_player)
      expect(next_player).to eq((initial_player + 1) % 2)
    end
  end

  describe '#check_final_round' do
    let(:player) { game.instance_variable_get(:@players).first }

    it 'does not trigger final round when score is below 3000' do
      player.instance_variable_set(:@score, 2999)
      game.send(:check_final_round)
      expect(game.instance_variable_get(:@final_round)).to be false
    end

    it 'triggers final round when score reaches 3000' do
      player.instance_variable_set(:@score, 3000)
      game.send(:check_final_round)
      expect(game.instance_variable_get(:@final_round)).to be true
    end
  end

  describe '#validate_num_players' do
    it 'raises ArgumentError for invalid number of players' do
      expect { game.send(:validate_num_players, 0) }.to raise_error(ArgumentError)
      expect { game.send(:validate_num_players, -1) }.to raise_error(ArgumentError)
    end

    it 'returns nil for valid number of players' do
      expect(game.send(:validate_num_players, 5)).to be_nil
    end
  end
end
