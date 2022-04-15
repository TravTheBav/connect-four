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
          print circle.to_s + ' '
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

  def column_full?(col_idx)
    pos = [0, col_idx]
    self[pos].nil? ? false : true
  end

  def empty_space?(pos)
    self[pos].nil?
  end

  def valid_column_idx?(idx)
    last_idx = rows[0].length - 1
    (idx >= 0) && (idx <= last_idx)
  end

  def place_piece(piece, col)
    return 'Error: column index out of range' if valid_column_idx?(col) == false
    return 'Error: that column is full' if column_full?(col)

    row = rows.length - 1 # starts at the 'bottom' of the board
    until empty_space?([row, col])
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

  def diagonal_match?
    right_diagonal_match? || left_diagonal_match?
  end

  def right_diagonal_match?
    rows.each_with_index do |row, r_idx|
      break if r_idx > rows.length - 4

      row.each_with_index do |value, c_idx|
        break if c_idx > row.length - 4

        unless value.nil?
          values = []
          4.times { |i| values << rows[r_idx + i][c_idx + i] }
          return true if values.all? { |ele| ele == value }
        end
      end
    end
    false
  end

  def left_diagonal_match?
    reversed = rows.map(&:reverse)

    reversed.each_with_index do |row, r_idx|
      break if r_idx > reversed.length - 4

      row.each_with_index do |value, c_idx|
        break if c_idx > row.length - 4

        unless value.nil?
          values = []
          4.times { |i| values << reversed[r_idx + i][c_idx + i] }
          return true if values.all? { |ele| ele == value }
        end
      end
    end
    false
  end

end
