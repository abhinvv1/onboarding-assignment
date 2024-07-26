# frozen_string_literal: true

require_relative 'die'
require_relative 'player'
require_relative 'score_calculator'
require_relative 'constants'

# The Game class manages the overall flow of the Greed game.
# It handles player turns, dice rolling, score calculation, and game progression.
class Game
  include Constants

  def initialize(num_players)
    validate_num_players(num_players)
    @players = num_players.times.map { |i| Player.new("Player #{i + 1}") } # players is a num_players size array of Player object
    @dice = Array.new(NUM_DICE) { Die.new }    # dice is 5 size array of Die objects
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
  def validate_num_players(num_players)
    unless num_players.is_a?(Integer) && num_players > 1
      raise ArgumentError, "Number of players must be an integer greater than 1"
    end
  end

  # Starts and manages the main game loop until the final round is complete.
  def play_turn
    puts "Turn #{@turn_number}:"
    puts "--------"
    current_player = @players[@current_player]
    round_score = 0
    remaining_dice = NUM_DICE

    loop do
      roll_dice(remaining_dice)
      display_roll(remaining_dice)
      turn_score, scoring_dice = ScoreCalculator.calculate(@dice.take(remaining_dice))
      if turn_score == 0
        puts "#{ROUND_SCORE} 0"
        puts "#{TOTAL_SCORE} #{current_player.score}"
        @current_player = (@current_player + 1) % @players.size
        return
      end

      round_score += turn_score
      puts "#{ROUND_SCORE} #{round_score}"
      puts "#{TOTAL_SCORE} #{current_player.score + (current_player.in_game ? round_score : 0)}"

      remaining_dice -= scoring_dice
      remaining_dice = NUM_DICE if remaining_dice <= 0  # If all dice scored, reset to 5

      if remaining_dice < NUM_DICE
        print format(ROLL_REMAINING_PROMPT, remaining_dice)
      else
        print ROLL_ALL_PROMPT
      end

      if gets.chomp.downcase != YES_INPUT
        current_player.add_score(round_score) if current_player.in_game || round_score >= MINIMUM_SCORE_TO_ENTER
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
    @final_round = true if @players[@current_player].score >= WINNING_SCORE
  end

  def next_player
    @current_player = (@current_player + 1) % @players.size
  end

  # Manages the final round of the game where each player gets one last turn.
  def play_final_round
    puts FINAL_ROUND
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
