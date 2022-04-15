# frozen_string_literal: true
require_relative 'board'
require_relative 'player'
require_relative 'piece'

class Game
  attr_reader :board, :player_1, :player_2

  def initialize
    @board = Board.new
    @player_1 = Player.new(:red)
    @player_2 = Player.new(:yellow)
  end

  def fetch_player_names
    player_1.fetch_name
    player_2.fetch_name
  end

  def game_over?
    if board.row_match? || board.column_match? || board.diagonal_match?
      true
    elsif board.full?
      true
    else
      false
    end
  end
end