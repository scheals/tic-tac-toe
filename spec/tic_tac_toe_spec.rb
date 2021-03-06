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
  describe '#legal?' do
    context 'when it returns false' do
      subject(:game_illegal) { described_class.new }
      it 'outputs an error message' do
        expect(game_illegal).to receive(:puts).with('This is not a legal move.')
        game_illegal.legal?('Atlantis')
      end
    end
    context "when space doesn't exist on the gameboard" do
      subject(:game_out_of_bounds) { described_class.new }
      before do
        allow(game_out_of_bounds).to receive(:puts).once
      end
      it 'returns false' do
        expect(game_out_of_bounds.legal?(1)).to be(false)
      end
    end
    context 'when space is already occupied' do
      subject(:game_occupied) { described_class.new }
      before do
        allow(game_occupied).to receive(:puts).once
        game_occupied.make_move('bottom left', 'X')
      end
      it 'returns false' do
        expect(game_occupied.legal?('bottom left')).to be(false)
      end
    end
    context 'when space is legal' do
      subject(:game_legal) { described_class.new }
      before do
        game_legal.make_move('top right', 'O')
        game_legal.make_move('top middle', 'X')
        game_legal.make_move('middle right', 'O')
      end
      it 'returns true' do
        expect(game_legal.legal?('middle middle')).to be(true)
      end
    end
  end
  describe '#make_move' do
    context 'when making a move' do
      subject(:game_move) { described_class.new }
      it 'updates the board' do
        game_move.make_move('top left', 'X')
        expect(game_move.first_row[0]).to be('X')
      end
    end
  end
end

describe TicTacToe do
  describe '#assign_signs' do
    subject(:game_signs) { described_class.new(player1, player2) }
    let(:player1) { instance_double(Player, name: 'Bob') }
    let(:player2) { instance_double(Player, name: 'Shappi') }
    before do
      allow(player1).to receive(:sign=).twice
      allow(player1).to receive(:sign).once
      allow(player2).to receive(:sign=).twice
      allow(player2).to receive(:sign).once
    end
    it 'sends first_player sign= with O' do
      expect(player1).to receive(:sign=).with('O')
      game_signs.assign_signs
    end

    it 'sends second_player sign= with X' do
      expect(player2).to receive(:sign=).with('X')
      game_signs.assign_signs
    end
  end

  describe '#setup_game' do
    subject(:game_setup) { described_class.new(player1, player2) }
    let(:player1) { instance_double(Player, name: 'Sam') }
    let(:player2) { instance_double(Player, name: 'Earl') }
    before do
      allow(player1).to receive(:sign=).twice
      allow(player1).to receive(:sign).thrice
      allow(player2).to receive(:sign=).twice
      allow(player2).to receive(:sign).once
      game_setup.setup_game
    end
    it "sets current_player to first player's name" do
      expect(game_setup.current_player).to be(player1.name)
    end

    it "sets current_sign to first player's sign" do
      expect(game_setup.current_sign).to be(player1.sign)
    end
  end
  describe '#play' do
    context 'when the move is valid' do
      subject(:in_game) { described_class.new(Player.new, Player.new, board) }
      let(:board) { instance_double(Gameboard) }
      before do
        valid_move = 'top left'
        allow(in_game).to receive(:ask_move).and_return(valid_move)
        allow(board).to receive(:make_move).once
      end
      it 'sends board a make_move message' do
        expect(board).to receive(:make_move)
        in_game.play
      end
    end
  end
  describe '#ask_move' do
    context 'when the move is legal' do
      subject(:ask_legal) { described_class.new }
      before do
        legal_move = 'top middle'
        allow(ask_legal).to receive(:gets).and_return(legal_move)
        allow(ask_legal).to receive(:puts).twice
      end
      it 'returns the move' do
        expect(ask_legal.ask_move).to eq('top middle')
      end
    end
  end
  describe '#declare_tie' do
    subject(:game_tie) { described_class.new(Player.new, Player.new, board) }
    let(:board) { instance_double(Gameboard) }
    before do
      allow(game_tie).to receive(:puts).twice
      allow(board).to receive(:puts).once
      allow(board).to receive(:show).once
    end
    it 'sends board a show message' do
      expect(board).to receive(:show)
      game_tie.declare_tie
    end
    it 'changes in_progress to false' do
      game_tie.declare_tie
      expect(game_tie.in_progress).to be(false)
    end
  end
  describe '#declare_winner' do
    subject(:game_winner) { described_class.new(Player.new, Player.new, board) }
    let(:board) { instance_double(Gameboard) }
    before do
      allow(game_winner).to receive(:puts).twice
      allow(board).to receive(:puts).once
    end
    it 'sends board a show message' do
      expect(board).to receive(:show)
      game_winner.declare_winner
    end
    it 'changes in_progress to false' do
      allow(board).to receive(:show).once
      game_winner.declare_winner
      expect(game_winner.in_progress).to be(false)
    end
  end
  describe '#start' do
    context 'when game is won after five rounds' do
      subject(:game_finish) { described_class.new(player1, player2, board) }
      let(:board) { instance_double(Gameboard) }
      let(:player1) { instance_double(Player, name: 'Mikhail') }
      let(:player2) { instance_double(Player, name: 'Behemoth') }
      before do
        allow(player1).to receive(:sign=)
        allow(player1).to receive(:sign)
        allow(player2).to receive(:sign=)
        allow(player2).to receive(:sign)
        allow(board).to receive(:show)
        allow(board).to receive(:win?).and_return(false, false, false, false, true)
        allow(board).to receive(:tie?).and_return(false, false, false, false)
        allow(game_finish).to receive(:play).exactly(5).times
        allow(game_finish).to receive(:puts)
      end
      it 'stops the loop and ends the game' do
        expect(game_finish).to receive(:puts).with("Congratulations to #{game_finish.current_player} on winning!").once
        game_finish.start
      end
    end
    context 'when game is tied' do
      subject(:game_tie) { described_class.new(player1, player2, board) }
      let(:board) { instance_double(Gameboard) }
      let(:player1) { instance_double(Player, name: 'Simon') }
      let(:player2) { instance_double(Player, name: 'Beth') }
      before do
        allow(player1).to receive(:sign=)
        allow(player1).to receive(:sign)
        allow(player2).to receive(:sign=)
        allow(player2).to receive(:sign)
        allow(board).to receive(:show)
        allow(board).to receive(:win?).and_return(false)
        allow(board).to receive(:tie?).and_return(true)
        allow(game_tie).to receive(:play)
        allow(game_tie).to receive(:puts)
      end
      it 'stops the loop and ends the game' do
        expect(game_tie).to receive(:puts).with("That's a tie!").once
        game_tie.start
      end
    end
  end
end
describe Player do
  describe '#sign=' do
    subject(:player_sign) { described_class.new }
    context 'when sign is changed' do
      it 'changes value to what was passed in' do
        player_sign.sign = 'X'
        expect(player_sign.sign).to be('X')
      end
    end
  end
end
