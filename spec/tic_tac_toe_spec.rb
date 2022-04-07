# frozen_string_literal: true

require_relative '../lib/tic_tac_toe'
require_relative '../lib/player'

describe TicTacToe do
  describe '#add_players' do
    context 'when players are already added' do
      subject(:playerful_game) { described_class.new }
      let(:player) { Player.new }

      before do
        playerful_game.add_players(player, player)
      end

      it 'executes an early return with an error message' do
        playerful_game.add_players(player, player)
        error_message = "#{player1_name} and #{player2_name} are already playing!"
        expect(playerful_game).to be(error_message)
      end
    end
  end
end
