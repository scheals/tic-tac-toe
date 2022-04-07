# frozen_string_literal: true

require_relative 'player'
require_relative 'rules'

# This is a class that lets you play a console Tic-Tac-Toe game, requires Rules module.
class TicTacToe
  include Rules
  attr_reader :gameboard, :player_turn, :current_player,
              :current_sign, :player1_sign, :player2_sign, :player1_name, :player2_name,
              :in_progress, :player1, :player2

  def initialize
    @gameboard = Array.new(3) { [' ', ' ', ' '] }
    @in_progress = true
  end

  def add_players(player1, player2)
    return "#{player1_name} and #{player2_name} are already playing!" if player1_name && player2_name

    @player1 = player1
    @player2 = player2
    @player1_name = player1.name
    @player2_name = player2.name
    @player1_sign = 'O'
    @player2_sign = 'X'
    @current_player = @player1_name
    @current_sign = @player1_sign
    "Added #{player1_name} as #{player1_sign} and #{player2_name} as #{player2_sign}."
  end

  def start
    return 'Players not added yet.' unless player1_name && player2_name

    return 'Game has ended.' unless in_progress

    introduce_rules
    play
  end

  def show_gameboard
    return introduce_rules unless player1_name && player2_name

    puts "\nCurrent game state:"
    puts "#{gameboard[0]}\n#{gameboard[1]}\n#{gameboard[2]}"
  end

  def introduce_rules
    puts "\nThis is how the gameboard is laid out:"
    p GAMEBOARD_COORDINATES[0]
    p GAMEBOARD_COORDINATES[1]
    p GAMEBOARD_COORDINATES[2]
    puts 'When asked where to put your sign use space names accordingly.'
    puts 'You win when you have three of your signs in a straight line.'
    puts "\nHave fun!"
  end

  private

  def declare_winner
    show_gameboard
    @in_progress = false
    puts "Congratulations to #{current_player} on winning!"
  end

  def declare_tie
    show_gameboard
    @in_progress = false
    puts "That's a tie!"
  end

  def play
    show_gameboard
    puts "#{current_player} as #{current_sign}"
    puts 'Where do you want to put your sign?'
    make_move(gets.chomp.to_s.downcase)
  end

  def make_move(space)
    gameboard_row = GAMEBOARD_COORDINATES.select { |row| row.include?(space) }.flatten
    coordinate1 = GAMEBOARD_COORDINATES.index(gameboard_row)
    coordinate2 = gameboard_row.index(space)
    return play unless legal?(coordinate1, coordinate2)

    gameboard[coordinate1][coordinate2] = current_sign
    win? ? declare_winner : change_player
  end

  def change_player
    return declare_tie if tie?

    @current_player = current_player == player1_name ? player2_name : player1_name
    @current_sign = current_sign == player1_sign ? player2_sign : player1_sign
    play
  end
end
