# frozen_string_literal: true

require_relative 'die'
require_relative 'player'
require_relative 'score_calculator'

# The Game class manages the overall flow of the Greed game.
# It handles player turns, dice rolling, score calculation, and game progression.
class Game
  def initialize(num_players)
    @players = num_players.times.map { |i| Player.new("Player #{i + 1}") } # players is a num_players size array of Player object
    @dice = Array.new(5) { Die.new }    # dice is 5 size array of Die objects
    @current_player = 0
    @final_round = false      # to determine whether it is a final round or not
    @turn_number = 1
  end

  def play      # main play loop which runs until we reach final round
    until @final_round
      play_turn
      check_final_round
      @turn_number += 1
    end
    play_final_round
    display_winner
  end

  private

  # Starts and manages the main game loop until the final round is complete.
  def play_turn
    puts "Turn #{@turn_number}:"
    puts "--------"
    current_player = @players[@current_player]
    round_score = 0
    remaining_dice = 5

    loop do
      roll_dice(remaining_dice)
      display_roll(remaining_dice)
      turn_score, scoring_dice = ScoreCalculator.calculate(@dice.take(remaining_dice))
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

  # Unrolls (resets) the specified number of dice.
  def unroll_dice(num_dice)
    num_dice.times { |i| @dice[i].unroll }
  end

  def display_roll(num_dice)
    puts "#{@players[@current_player].name} rolls: #{@dice.take(num_dice).map(&:value).join(', ')}"
  end

  def check_final_round
    @final_round = true if @players[@current_player].score >= 3000
  end

  def next_player
    @current_player = (@current_player + 1) % @players.size
  end

  # Manages the final round of the game where each player gets one last turn.
  def play_final_round
    puts "Final round!"
    (@players.size - 1).times do
      play_turn
      next_player
    end
  end

  def display_winner
    winner = @players.max_by(&:score)
    puts "The winner is #{winner.name} with a score of #{winner.score}!"
  end
end