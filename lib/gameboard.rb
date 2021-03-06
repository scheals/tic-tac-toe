# frozen_string_literal: true

# This a class that handles a TicTacToe board.
class Gameboard
  attr_reader :gameboard

  def game_signs
    %w[X O].freeze
  end

  def coordinates
    [
      ['top left', 'top middle', 'top right'],
      ['middle left', 'middle middle', 'middle right'],
      ['bottom left', 'bottom middle', 'bottom right']
    ].freeze
  end

  def first_row
    gameboard[0]
  end

  def second_row
    gameboard[1]
  end

  def third_row
    gameboard[2]
  end

  def initialize
    @gameboard = Array.new(3) { [' ', ' ', ' '] }
  end

  def make_move(space, sign)
    target_row = coordinates.select { |row| row.include?(space) }.flatten
    coordinate1 = coordinates.index(target_row)
    coordinate2 = target_row.index(space)
    gameboard[coordinate1][coordinate2] = sign
  end

  def show
    puts "#{first_row}\n#{second_row}\n#{third_row}"
  end

  def win?
    return true if three_in_a_row? || three_in_a_column? || three_in_a_diagonal?

    false
  end

  def tie?
    return true if gameboard.select { |row| (row.count('X') + row.count('O')) == 3 }.length == 3

    false
  end

  def legal?(space)
    return true if coordinates.any? { |row| row.include?(space) } && !occupied?(space)

    puts 'This is not a legal move.'
    false
  end

  private

  def three_in_a_row?
    return false if gameboard.select { |row| row.all?('X') || row.all?('O') }.empty?

    true
  end

  def three_in_a_column?
    columns = gameboard.transpose
    return false if columns.select { |column| column.all?('X') || column.all?('O') }.empty?

    true
  end

  def three_in_a_diagonal?
    diagonals = create_diagonals
    return false if diagonals.select { |diagonal| diagonal.all?('X') || diagonal.all?('O') }.empty?

    true
  end

  def create_diagonals
    top_left_bottom_right = []
    top_right_bottom_left = []
    gameboard.each_with_index do |row, index|
      top_left_bottom_right << row[index]
    end
    gameboard.reverse.each_with_index do |row, index|
      top_right_bottom_left << row[index]
    end
    [top_left_bottom_right, top_right_bottom_left]
  end

  def occupied?(space)
    target_row = coordinates.select { |row| row.include?(space) }.flatten
    coordinate1 = coordinates.index(target_row)
    coordinate2 = target_row.index(space)
    game_signs.include?(gameboard[coordinate1][coordinate2])
  end
end
