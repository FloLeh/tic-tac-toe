require_relative 'board'
require_relative 'board_spot_management'
require_relative 'input_validator'

class Game
  include BoardSpotManagement
  include InputValidator

  attr_reader :board

  PLAYER_1 = 'O'
  PLAYER_2 = 'X'

  def initialize
    @board = Board.new
  end

  def start_game
    print_current_board_state
    puts "\nEnter [0-8]:\n"

    until game_over? || tie?
      choose_player_spot
      eval_board if !game_over? && !tie?
      print_current_board_state
    end

    puts "\nGame over"
  end

  def choose_player_spot
    spot = get_spot_from_player
    board.choose_spot(spot, PLAYER_1)
  end

  def eval_board
    spot = nil
    until spot
      if board_spots[4] == '4'
        spot = 4
        board.choose_spot(spot, PLAYER_2)
      else
        spot = get_best_move(PLAYER_2)
        if not_chosen_spot?(spot)
          board.choose_spot(spot, PLAYER_2)
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil

    board_spots.each do |s|
      available_spaces << s if s != 'X' && s != 'O'
    end

    available_spaces.each do |as|
      board_spots[as.to_i] = PLAYER_1
      if game_over?
        best_move = as.to_i
        board_spots[as.to_i] = as
        return best_move
      else
        board_spots[as.to_i] = PLAYER_2
        if game_over?
          best_move = as.to_i
          board_spots[as.to_i] = as
          return best_move
        else
          board_spots[as.to_i] = as
        end
      end
    end

    return best_move if best_move

    n = rand(0..available_spaces.count)
    available_spaces[n].to_i
  end
end
