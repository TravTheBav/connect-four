# frozen_string_literal: true

require 'colorize'

class Board
  attr_accessor :rows

  def initialize
    @rows = Array.new(6) { Array.new(7, nil) }
  end

  def render
    @rows.each do |row|
      row.each do |circle|
        if circle.nil?
          print '⬤'.colorize(:white) + ' '
        else
          print circle + ' '
        end
      end
      puts
    end
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @rows[row][col] = value
  end

  def place_piece(piece, col)
    row = rows.length - 1 # starts at the 'bottom' of the board
    until self[[row, col]].nil?
      return 'This column is full' if row == -1

      row -= 1
    end
    self[[row, col]] = piece      
  end
end