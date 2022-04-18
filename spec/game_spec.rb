# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:connect_four) { described_class.new }

  describe '#game_over?' do
    let(:board) { instance_double('game-board') }

    context 'when no win conditions are met' do
      before do
        allow(board).to receive(:row_match?).and_return(false)
        allow(board).to receive(:column_match?).and_return(false)
        allow(board).to receive(:diagonal_match?).and_return(false)
        allow(board).to receive(:full?).and_return(false)
      end

      it 'returns false' do
        connect_four.instance_variable_set(:@board, board)
        expect(connect_four).not_to be_game_over
      end
    end

    context 'when one win condition is met' do
      before do
        allow(board).to receive(:row_match?).and_return(false)
        allow(board).to receive(:column_match?).and_return(false)
        allow(board).to receive(:diagonal_match?).and_return(true)
        allow(board).to receive(:full?).and_return(false)
      end

      it 'returns true' do
        connect_four.instance_variable_set(:@board, board)
        expect(connect_four).to be_game_over
      end
    end

    context 'when the board is filled and there is no winner' do
      before do
        allow(board).to receive(:row_match?).and_return(false)
        allow(board).to receive(:column_match?).and_return(false)
        allow(board).to receive(:diagonal_match?).and_return(false)
        allow(board).to receive(:full?).and_return(true)
      end

      it 'returns true' do
        connect_four.instance_variable_set(:@board, board)
        expect(connect_four).to be_game_over
      end
    end
  end
end
