# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new(:red) }

  describe '#fetch_column_choice' do
    context 'when a char from 0 - 6 is entered' do
      before do
        allow(player).to receive(:puts)
        allow(player).to receive(:gets).and_return('6')
      end

      it 'returns an integer between 0 and 6' do
        result = player.fetch_column_choice
        expect(result).to eq(6)
      end
    end

    context 'when a char outside the valid range is entered and then a valid char is entered' do
      before do
        allow(player).to receive(:puts)
        allow(player).to receive(:gets).and_return('9', '0')
      end

      it 'reprompts the player for a new input and then returns an integer' do
        result = player.fetch_column_choice
        expect(result).to eq(0)
      end
    end
  end
end