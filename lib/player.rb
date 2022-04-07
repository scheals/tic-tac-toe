# frozen_string_literal: true

# This is a class that creates players for games.
class Player
  attr_accessor :sign
  attr_reader :name

  def initialize(name = ['Player', 'Foo', 'Bar', 'TicTacToe Champion', 'Basil', 'Cross', 'Nought'].sample)
    @name = name
    @sign = nil
  end
end
