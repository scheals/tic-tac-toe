# frozen_string_literal: true

# Those are the Rules for TicTacToe.
module Rules
  GAME_SIGNS = %w[X O].freeze

  GAMEBOARD_COORDINATES = [
    ['top left', 'top middle', 'top right'],
    ['middle left', 'middle middle', 'middle right'],
    ['bottom left', 'bottom middle', 'bottom right']
  ].freeze

  private

  def win?
    return true if three_in_a_row? || three_in_a_column? || three_in_a_diagonal?

    false
  end

  def tie?
    return false if gameboard.select { |row| row.all? { |element| GAME_SIGNS.include?(element) } }[2].nil?

    true
  end

  def sign?(first_index, second_index)
    return true if gameboard[first_index][second_index] != ' '

    false
  end

  def three_in_a_row?
    return false if gameboard.select { |row| row.all?(current_sign.to_s) }.empty?

    true
  end

  def three_in_a_column?
    columns = gameboard.transpose
    return false if columns.select { |column| column.all?(current_sign.to_s) }.empty?

    true
  end

  def three_in_a_diagonal?
    top_left_bottom_right = [gameboard[0][0], gameboard[1][1], gameboard[2][2]]
    top_right_bottom_left = [gameboard[0][2], gameboard[1][1], gameboard[2][0]]
    diagonals = [top_left_bottom_right, top_right_bottom_left]
    return false if diagonals.select { |diagonal| diagonal.all?(current_sign.to_s) }.empty?

    true
  end

  def legal?(first_index, second_index)
    return true unless first_index.nil? || sign?(first_index, second_index)

    puts 'This is not a legal move.'
    false
  end
end
