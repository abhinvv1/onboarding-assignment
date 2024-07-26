# frozen_string_literal: true

module Constants
  NUM_DICE = 5
  MINIMUM_SCORE_TO_ENTER = 300
  YES_INPUT = 'y'

  ROLL_REMAINING_PROMPT = "Do you want to roll the remaining %d dice? (y/n): "
  ROLL_ALL_PROMPT = "Do you want to roll all #{NUM_DICE} dice again? (y/n): "
  ROUND_SCORE = "Score in this round:"
  TOTAL_SCORE = "Total score:"
  FINAL_ROUND = "Final round!"

  WINNING_SCORE = 3000
  SINGLE_FIVE_SCORE = 50
  SINGLE_ONE_SCORE = 100
  TRIPLE_ONE_SCORE = 1000
  TRIPLE_SCORE = 100
  DIE_ARRAY = [1, 2, 3, 4, 5, 6]
end
