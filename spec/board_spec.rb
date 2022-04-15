# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#column_full?' do
    context 'when a column is empty' do
      it 'returns false' do
        result = board.column_full?(0)
        expect(result).to be false
      end
    end

    context 'when a column is half full' do
      before do
        board.instance_variable_set(:@rows, [
          [nil, nil, nil],
          [nil, :X, nil],
          [nil, :X, nil]
        ])
      end

      it 'returns false' do
        result = board.column_full?(1)
        expect(result).to be false
      end
    end

    context 'when a column is full' do
      before do
        board.instance_variable_set(:@rows, [
          [nil, :X, nil],
          [nil, :X, nil],
          [nil, :X, nil]
        ])
      end

      it 'returns true' do
        result = board.column_full?(1)
        expect(result).to be true
      end
    end
  end

  describe '#empty_space?' do
    context 'when passed in an empty position' do
      it 'returns true' do
        result = board.empty_space?([0,0])
        expect(result).to be true
      end
    end

    context 'when passed in a filled position' do
      before do
        board.instance_variable_set(:@rows, [
          [nil, :X, nil],
          [nil, :X, nil],
          [nil, :X, nil]
        ])
      end

      it 'returns false' do
        result = board.empty_space?([0, 1])
        expect(result).to be false
      end
    end
  end

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
    context 'when there are no horizontal four of a kind matches' do
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

  describe '#column_match?' do
    context 'when there are no vertical four of a kind matches' do
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

  describe '#right_diagonal_match?' do
    context 'when there is not a right diagonal match' do
      it 'returns false' do
        expect(board).not_to be_right_diagonal_match
      end
    end

    context 'when there is a right diagonal match' do
      before do
        board.instance_variable_set(:@rows, [
          [:X, nil, nil, nil],
          [nil, :X, nil, nil],
          [nil, nil, :X, nil],
          [nil, nil, nil, :X]
        ])
      end

      it 'returns true' do
        expect(board).to be_right_diagonal_match
      end
    end
  end

  describe '#left_diagonal_match?' do
    context 'when there is not a left diagonal match' do
      it 'returns false' do
        expect(board).not_to be_left_diagonal_match
      end
    end

    context 'when there is a left diagonal match' do
      before do
        board.instance_variable_set(:@rows, [
          [nil, nil, nil, :X],
          [nil, nil, :X, nil],
          [nil, :X, nil, nil],
          [:X, nil, nil, nil]
        ])
      end

      it 'returns true' do
        expect(board).to be_left_diagonal_match
      end
    end
  end

  describe '#diagonal_match?' do
    context 'when there are no diagonal matches' do
      before do
        allow(board).to receive(:right_diagonal_match?).and_return(false)
        allow(board).to receive(:left_diagonal_match?).and_return(false)
      end

      it 'returns false' do
        expect(board).not_to be_diagonal_match
      end
    end

    context 'when there is a diagonal match going downward-left' do
      before do
        allow(board).to receive(:right_diagonal_match?).and_return(false)
        allow(board).to receive(:left_diagonal_match?).and_return(true)
      end

      it 'returns true' do
        expect(board).to be_diagonal_match
      end
    end

    context 'when there is a diagonal match going downward-right' do
      before do
        allow(board).to receive(:right_diagonal_match?).and_return(true)
        allow(board).to receive(:left_diagonal_match?).and_return(false)
      end

      it 'returns true' do
        expect(board).to be_diagonal_match
      end
    end
  end

end
