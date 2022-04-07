# frozen_string_literal: true

require_relative './lib/player'
require_relative './lib/tic_tac_toe'

game = TicTacToe.new
game.add_players(Player.new, Player.new)
game.start
