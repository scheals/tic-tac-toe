# frozen_string_literal: true

# This is a class that creates players for games.
class Player
  attr_reader :player_name, :win_count, :tie_count, :lose_count

  def initialize(player_name = ['Player', 'Foo', 'Bar', 'TicTacToe Champion', 'Basil', 'Cross', 'Nought'].sample)
    @player_name = player_name
  end

  def show_stats
    puts "Won: #{win_count} Lost: #{lose_count} Tied: #{tie_count}"
  end

  def self.award_points(winner, loser)
    winner.add_win
    loser.add_lose
  end

  def self.award_tie(first_player, second_player)
    first_player.add_tie
    second_player.add_tie
  end

  def add_win
    return @win_count = 1 if win_count.nil?

    @win_count += 1
  end

  def add_tie
    return @tie_count = 1 if tie_count.nil?

    @tie_count += 1
  end

  def add_lose
    return @lose_count = 1 if lose_count.nil?

    @lose_count += 1
  end
end
