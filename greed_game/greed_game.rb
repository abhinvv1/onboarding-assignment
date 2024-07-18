require_relative 'game'


# Start the game
print "Enter number of players: "
num_players = gets.to_i
# puts num_players
game = Game.new(num_players)
game.play