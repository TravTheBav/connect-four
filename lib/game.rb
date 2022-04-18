# frozen_string_literal: true
require_relative 'board'
require_relative 'player'
require_relative 'piece'

class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new(:red), Player.new(:yellow)]
    @current_player = players[0]
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

  def play
    puts 'Welcome to Connect-4'
    until game_over?
      board.render
      column_idx = current_player.fetch_column_choice


  end
end
