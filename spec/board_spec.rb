# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#place_piece' do
    subject(:board) { described_class.new }    

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
end