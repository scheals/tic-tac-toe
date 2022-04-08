# frozen_string_literal: true

require_relative 'player'
require_relative 'gameboard'

# This is a class that lets you play a console Tic-Tac-Toe game, requires Rules module.
class TicTacToe
  attr_reader :board, :player_turn, :current_player,
              :current_sign, :in_progress, :first_player, :second_player

  def initialize(player1 = Player.new, player2 = Player.new, gameboard = Gameboard.new)
    @in_progress = true
    @first_player = player1
    @second_player = player2
    @board = gameboard
    setup_game
  end

  def setup_game
    assign_signs
    @current_player = first_player.name
    @current_sign = first_player.sign
  end

  def assign_signs
    first_player.sign = 'O'
    second_player.sign = 'X'
  end

  def start
    introduce_rules
    while in_progress
      board.show
      play
      board.win? ? declare_winner : change_sides
    end
  end

  def introduce_rules
    puts "\nThis is how the gameboard is laid out:"
    puts "#{board.gameboard[0]}\n#{board.gameboard[1]}\n#{board.gameboard[2]}"
    puts 'When asked where to put your sign use space names accordingly.'
    puts 'You win when you have three of your signs in a straight line.'
    puts "\nHave fun!"
  end

  def declare_winner
    board.show
    @in_progress = false
    puts "Congratulations to #{current_player} on winning!"
  end

  def declare_tie
    board.show
    @in_progress = false
    puts "That's a tie!"
  end

  def play
    move = ask_move
    board.make_move(move, current_sign)
  end

  def ask_move
    puts "#{current_player} as #{current_sign}"
    puts 'Where do you want to put your sign?'
    move = gets.chomp.to_s.downcase
    return move if board.legal?(move)

    ask_move
  end

  def change_sides
    return declare_tie if board.tie?

    change_player
    change_sign
  end

  def change_player
    @current_player = current_player == first_player.name ? second_player.name : first_player.name
  end

  def change_sign
    @current_sign = current_sign == first_player.sign ? second_player.sign : first_player.sign
  end
end
