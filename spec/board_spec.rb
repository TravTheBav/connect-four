# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#place_piece' do
    context 'when the column is empty' do
      before do
        board.instance_variable_set(:@rows, [
          [nil, nil, nil],
          [nil, nil, nil],
          [nil, nil, nil]
        ])
      end

      it 'piece goes to the bottom of the column' do
        expected_outcome = [
          [nil, nil, nil],
          [nil, nil, nil],
          [:X, nil, nil]
        ]
        board.place_piece(:X, 0)
        expect(board.rows).to eq(expected_outcome)
      end
    end

    context 'when the column has some pieces' do
      before do
        board.instance_variable_set(:@rows, [
          [nil, nil, nil],
          [nil, :X, nil],
          [nil, :X, nil]
        ])
      end

      it 'piece goes to the next empty space in the column' do
        expected_outcome = [
          [nil, :X, nil],
          [nil, :X, nil],
          [nil, :X, nil]
        ]
        board.place_piece(:X, 1)
        expect(board.rows).to eq(expected_outcome)
      end
    end

    context 'when the column is full' do
      before do
        board.instance_variable_set(:@rows, [
          [nil, :X, nil],
          [nil, :X, nil],
          [nil, :X, nil]
        ])
      end

      it 'notifies that column is full' do
        error_msg = board.place_piece(:X, 1)
        expect(error_msg).to eq('This column is full')
      end
    end
  end

  describe '#row_match?' do
    context 'when there is not a horizontal four of a kind match' do
      before do
        board.instance_variable_set(:@rows, [
          [nil, nil, nil, nil],
          [nil, nil, nil, nil],
          [:X, :X, :X, nil],
          [nil, nil, nil, nil],
        ])
      end

      it 'returns false' do
        expect(board).not_to be_row_match
      end
    end

    context 'when there is a horizontal match' do
      before do
        board.instance_variable_set(:@rows, [
          [nil, nil, nil, nil],
          [nil, nil, nil, nil],
          [:X, :X, :X, :X],
          [nil, nil, nil, nil],
        ])
      end

      it 'returns true' do
        expect(board).to be_row_match
      end
    end
  end

  describe 'column_match?' do
    context 'when there is not a vertical four of a kind match' do
      before do
        board.instance_variable_set(:@rows, [
          [:X, nil, nil, nil],
          [:X, nil, nil, nil],
          [:X, nil, nil, nil],
          [nil, nil, nil, nil],
        ])
      end

      it 'returns false' do
        expect(board).not_to be_column_match
      end
    end

    context 'when there is a vertical match' do
      before do
        board.instance_variable_set(:@rows, [
          [nil, nil, :X, nil],
          [nil, nil, :X, nil],
          [nil, nil, :X, nil],
          [nil, nil, :X, nil]
        ])
      end

      it 'returns true' do
        expect(board).to be_column_match
      end
    end
  end
end
