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

  def row_match?
    rows.each do |row|
      row.each_with_index do |value, idx|
        break if idx > row.length - 4

        unless value.nil?
          return true if row[idx..idx + 3].all? { |ele| ele == value }
        end
      end
    end
    false
  end

  def column_match?
    rows.transpose.each do |col|
      col.each_with_index do |value, idx|
        break if idx > col.length - 4

        unless value.nil?
          return true if col[idx..idx + 3].all? { |ele| ele == value }
        end
      end
    end
    false
  end
end
