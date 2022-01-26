# frozen_string_literal: true

# I am explaining the class here to satisfy Rubocop.
class TicTacToe
  attr_reader :gameboard, :game_count, :game_name, :player1_name, :player2_name,
              :player_turn, :current_player, :current_sign, :player1_sign, :player2_sign

  GAMEBOARD_COORDINATES = [
    ['top left', 'top middle', 'top right'],
    ['middle left', 'middle middle', 'middle right'],
    ['bottom left', 'bottom middle', 'bottom right']
  ].freeze
  @game_count = 0

  def initialize(player1_name = 'Player 1', player2_name = 'Player 2')
    @player1_name = player1_name.to_s
    @player1_sign = 'O'
    @player2_name = player2_name.to_s
    @player2_sign = 'X'
    @gameboard = Array.new(3) { [' ', ' ', ' '] }
    @game_name = "Game #{self.class.count}"
    @current_player = @player1_name
    @current_sign = @player1_sign
    @in_progress = true
  end

  def start
    return "Game has ended in #{current_player} victory!" unless @in_progress

    puts "\nThis is how the gameboard is laid out:"
    p GAMEBOARD_COORDINATES[0]
    p GAMEBOARD_COORDINATES[1]
    p GAMEBOARD_COORDINATES[2]
    puts 'When asked where to put your sign use space names accordingly.'
    puts "\nHave fun!"
    play
  end

  def show_gameboard
    puts "\nCurrent game state:"
    p gameboard[0]
    p gameboard[1]
    p gameboard[2]
  end

  def what_game
    "#{game_name} with #{player1_name} and #{player2_name}"
  end

  def self.count
    @game_count += 1
  end

  private

  def declare_winner
    show_gameboard
    win_message = "Congratulations to #{@current_player} for winning!"
    @in_progress = false
    win_message
  end

  def win?
    return false if gameboard.select { |row| row.all?('X') }.empty?

    true
  end

  def play
    show_gameboard
    puts "#{@current_player} as #{@current_sign}"
    puts 'Where do you want to put your sign?'
    make_move(gets.chomp.to_s.downcase)
  end

  def make_move(space)
    gameboard_row = GAMEBOARD_COORDINATES.select { |row| row.include?(space) }.flatten
    if gameboard_row.empty?
      puts 'Try again.'
      return play
    end
    coordinate1 = GAMEBOARD_COORDINATES.index(gameboard_row)
    coordinate2 = gameboard_row.index(space)
    gameboard[coordinate1][coordinate2] = @current_sign
    win? ? declare_winner : change_player
  end

  def change_player
    @current_player = current_player == player1_name ? player2_name : player1_name
    @current_sign = current_sign == player1_sign ? player2_sign : player1_sign
    play
  end
end
