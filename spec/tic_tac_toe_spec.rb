# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/tictactoe'
require_relative '../lib/player'
require_relative '../lib/gameboard'

describe Gameboard do
  describe '#win?' do
    context 'when no win condition has been reached' do
      subject(:mid_game) { described_class.new }
      before do
        mid_game.make_move('bottom left', 'O')
        mid_game.make_move('middle middle', 'X')
        mid_game.make_move('bottom right', 'O')
      end
      it 'returns false' do
        expect(mid_game.win?).to be(false)
      end
    end
    context 'when there are three of the same sign in a row' do
      subject(:game_row) { described_class.new }
      before do
        game_row.make_move('bottom left', 'O')
        game_row.make_move('bottom right', 'O')
        game_row.make_move('bottom middle', 'O')
      end
      it 'returns true' do
        expect(game_row.win?).to be(true)
      end
    end
    context 'when there are three of the same sign in a column' do
      subject(:game_column) { described_class.new }
      before do
        game_column.make_move('bottom left', 'O')
        game_column.make_move('middle left', 'O')
        game_column.make_move('top left', 'O')
      end
      it 'returns true' do
        expect(game_column.win?).to be(true)
      end
    end
    context 'when there are three of the same sign in a diagonal' do
      subject(:game_diagonal) { described_class.new }
      before do
        game_diagonal.make_move('bottom left', 'O')
        game_diagonal.make_move('middle middle', 'O')
        game_diagonal.make_move('top right', 'O')
      end
      it 'returns true' do
        expect(game_diagonal.win?).to be(true)
      end
    end
  end
  describe '#tie?' do
    context 'when the game is underway' do
      subject(:mid_tie_game) { described_class.new }
      before do
        mid_tie_game.make_move('bottom left', 'O')
        mid_tie_game.make_move('bottom middle', 'X')
        mid_tie_game.make_move('bottom right', 'O')
      end
      it 'returns false' do
        expect(mid_tie_game.tie?).to be(false)
      end
    end
    context 'when the game is tied' do
      subject(:game_tie) { described_class.new }
      before do
        game_tie.make_move('bottom left', 'O')
        game_tie.make_move('bottom middle', 'X')
        game_tie.make_move('bottom right', 'O')
        game_tie.make_move('middle left', 'O')
        game_tie.make_move('middle middle', 'X')
        game_tie.make_move('middle right', 'O')
        game_tie.make_move('top left', 'X')
        game_tie.make_move('top middle', 'O')
        game_tie.make_move('top right', 'X')
      end
      it 'returns true' do
        expect(game_tie.tie?).to be(true)
      end
      it 'and nobody won' do
        expect(game_tie.win?).to be(false)
      end
    end
  end
end
