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
        file = code[0] - ?a
        rank = 7 - (code[1] - ?1)

        validate_rank_file(file, rank)

        return file, rank
    end

    def validate_rank_file(file, rank)
        if not (0..7) === file
            raise "bad file: #{file}"
        end

        if not (0..7) === rank 
            raise "bad rank: #{rank}"
        end
    end


    def indices2code(file, rank)
        validate_rank_file(file, rank)

        file_letter = (file+ ?a).chr
        rank_number = (7 - rank+ ?1).chr

        return file_letter + rank_number
    end
end

board = Board.new
board.squares.each_with_index{|squares, rank|
    squares.each_with_index{|square, file|
    }
}

puts


