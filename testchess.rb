require "chess"
require "test/unit"

class TestChess < Test::Unit::TestCase
    def test_algebraic_notation

        board = Board.new

        # Corners of the board. See http://tinyurl.com/ctmjfl
        equals = {
            # file+rank => [file,rank]
            "a8" => [0,0],
            "h8" => [7,0],
            "a1" => [0,7],
            "h1" => [7,7]}

        equals.each{|code, indices|
            puts "#{code} <-> #{indices}"
            assert_equal(code, board.indices2code(indices[0], indices[1]))
            assert_equal(indices, board.code2indices(code))
        }
    end
end

