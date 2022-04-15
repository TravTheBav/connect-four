# frozen_string_literal: true
require 'colorize'

class Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
    '⬤'.colorize(color)
  end
end
