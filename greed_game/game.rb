# frozen_string_literal: true

require_relative 'die'
require_relative 'player'

class Game
  def initialize(num_players)
    @players = num_players.times.map { |i| Player.new("Player #{i + 1}") }
    @dice = Array.new(5) { Die.new }
    @current_player = 0
    @final_round = false
    @turn_number = 1
  end

  def play
    until @final_round
      play_turn
      check_final_round
      @turn_number += 1
    end
    play_final_round
    announce_winner
  end

  private

  def play_turn
    puts "Turn #{@turn_number}:"
    puts "--------"
    current_player = @players[@current_player]
    round_score = 0
    remaining_dice = 5

    loop do
      roll_dice(remaining_dice)
      display_roll(remaining_dice)
      turn_score, scoring_dice = calculate_score
      if turn_score == 0
        puts "Score in this round: 0"
        puts "Total score: #{current_player.score}"
        @current_player = (@current_player + 1) % @players.size
        return
      end

      round_score += turn_score
      puts "Score in this round: #{round_score}"
      puts "Total score: #{current_player.score + (current_player.in_game ? round_score : 0)}"

      remaining_dice -= scoring_dice
      remaining_dice = 5 if remaining_dice <= 0  # If all dice scored, reset to 5

      if remaining_dice < 5
        print "Do you want to roll the remaining #{remaining_dice} dice? (y/n): "
      else
        print "Do you want to roll all 5 dice again? (y/n): "
      end

      if gets.chomp.downcase != 'y'
        current_player.add_score(round_score) if current_player.in_game || round_score >= 300
        @current_player = (@current_player + 1) % @players.size
        break
      end
    end
  end

  def roll_dice(num_dice)
    num_dice.times { |i| @dice[i].roll }
  end
  def unroll_dice(num_dice)
    num_dice.times { |i| @dice[i].unroll }
  end

  def display_roll(num_dice)
    puts "#{@players[@current_player].name} rolls: #{@dice.take(num_dice).map(&:value).join(', ')}"
  end

  def calculate_score
    counts = @dice.map(&:value).tally
    puts counts
    score = 0
    scoring_dice = 0

    [1, 6, 5, 4, 3, 2].each do |num|
      if counts[num] && counts[num] >= 3
        score += (num == 1 ? 1000 : num * 100)
        scoring_dice += 3
        counts[num] -= 3
      end
    end

    # Check for individual 1s and 5s
    if counts[1]
      score += counts[1] * 100
      scoring_dice += counts[1]
    end
    if counts[5]
      score += counts[5] * 50
      scoring_dice += counts[5]
    end
    unroll_dice 5
    [score, scoring_dice]
  end

  def check_final_round
    @final_round = true if @players[@current_player].score >= 3000
  end

  def next_player
    @current_player = (@current_player + 1) % @players.size
  end

  def play_final_round
    puts "Final round!"
    (@players.size - 1).times do
      play_turn
      next_player
    end
  end

  def announce_winner
    winner = @players.max_by(&:score)
    puts "The winner is #{winner.name} with a score of #{winner.score}!"
  end
end