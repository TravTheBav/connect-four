# frozen_string_literal: true
require_relative 'board'
require_relative 'player'
require_relative 'piece'

class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new(:red), Player.new(:yellow)]
  end

  def game_over?
    if winner? || board.full?
      true
    else
      false
    end
  end

  def winner?
    board.row_match? || board.column_match? || board.diagonal_match?
  end

  def play
    puts 'Welcome to Connect-4'
    until game_over?
      board.render
      column_idx = current_player.fetch_column_choice
      while board.column_full?(column_idx)
        column_idx = current_player.fetch_column_choice
      end
      board.place_piece(current_player.color, column_idx)
      switch_player
      system('clear')
    end

    board.render

    if winner?
      puts "#{last_player.color} player wins"
    else
      puts 'No winner'
    end
  end

  def current_player
    @players[0]
  end

  def last_player
    @players[1]
  end

  def switch_player
    @players.reverse!
  end
end
