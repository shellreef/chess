#!/usr/bin/ruby
# Created:20090324
# By Jeff Connelly
#
# Chess

require 'enumerator'

class Piece
    attr_accessor :color
end

class Rook < Piece
end

class Knight < Piece
end

class Bishop < Piece
end

class Queen < Piece
end

class King < Piece
end

class Pawn < Piece
end

class Board
    attr_accessor :squares

    def initialize()
        @squares = [
            # 0,0 is a8
            [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook],
            [Pawn] * 8,
            [nil] * 8,
            [nil] * 8,
            [nil] * 8,
            [nil] * 8,
            [Pawn] * 8,
            [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
            # 7,7 is h1
        ]
    end

    # Convert an algebraic notation code for a square, for example
    # a1, to 0-based indices into the board array, for example 0,0
    def code2indices(code)
        if code.length != 2
            raise "bad algebratic notation #{code}"
        end

        # Note that rank & file are zero-based here
        rank = code[0] - ?a
        file = 7 - (code[1] - ?1)

        validate_rank_file(rank, file)

        return rank, file
    end

    def validate_rank_file(rank, file)
        if not (0..7) === rank 
            raise "bad rank: #{rank} in notation #{code}"
        end

        if not (0..7) === file
            raise "bad file: #{file} in notation #{code}"
        end
    end


    def indices2code(rank, file)
        validate_rank_file(rank, file)

        rank_letter = (rank + ?a).chr
        file_number = (7 - file + ?1).chr

        return rank_letter + file_number
    end
end

board = Board.new
board.squares.each_with_index{|squares, rank|
    squares.each_with_index{|square, file|
    }
}

puts

puts board.indices2code(0, 0)
puts board.code2indices("a8")

