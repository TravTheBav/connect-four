# frozen_string_literal: true

require 'colorize'

class Board
  def initialize
    @rows = Array.new(6) { Array.new(7, '⬤') }
  end

  def render
    @rows.each do |row|
      row.each do |circle|
        print circle.colorize(:color => :white) + ' '
      end
      puts
    end
  end
end