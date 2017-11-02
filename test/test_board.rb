require_relative '../src/board'
require 'test/unit'

class TestBoard < Test::Unit::TestCase
  def test_board_spots
    assert_equal(['0', '1', '2', '3', '4', '5', '6', '7', '8'], Board.new.spots)
  end

  def test_board_choose_spot
    board = Board.new
    assert_equal('2', board.spots[2])
    board.choose_spot(2, 'X')
    assert_equal('X', board.spots[2])
  end
end
