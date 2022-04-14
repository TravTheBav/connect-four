require_relative 'board'

b = Board.new
b.render
2.times { b.place_piece('X', 4) }
2.times { puts }
b.render

2.times{ puts }
6.times { b.place_piece('O', 0) }
b.render
p b.place_piece('O', 0)