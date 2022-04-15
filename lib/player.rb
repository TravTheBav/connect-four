# frozen_string_literal: true

class Player
  def initialize(color)
    @color = color
  end

  def fetch_name
    puts 'Enter your name:'
    @name = gets.chomp
  end
end