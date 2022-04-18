# frozen_string_literal: true

class Player
  def initialize(color)
    @color = color
  end

  def fetch_column_choice
    puts "#{@color} player - choose a column from 0 - 6:"
    input = gets.chomp
    until input.match?(/[0-6]/)
      puts 'Invalid character entered; pick a number between 0 and 6'
      input = gets.chomp
    end
    input.to_i
  end

end