# frozen_string_literal: true
require_relative 'board'
require_relative 'player'

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
    player_turn until game_over?
    print_end_message
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

  def player_turn
    board.render
    column_idx = current_player.fetch_column_choice
    while board.column_full?(column_idx)
      column_idx = current_player.fetch_column_choice
    end
    board.place_piece(current_player.color, column_idx)
    switch_player
    system('clear')
  end

  def print_end_message
    board.render
    if winner?
      puts "#{last_player.color} player wins"
    else
      puts 'No winner'
    end
  end
end
