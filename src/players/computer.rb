require_relative 'player'

class Computer < Player
  def choose_computer_spot(board)
    spot = nil
    until spot
      if board.spots[4] == '4'
        spot = 4
        board.choose_spot(spot, mark)
      else
        spot = get_spot(board)
        if board.not_chosen_spot?(spot)
          board.choose_spot(spot, mark)
        else
          spot = nil
        end
      end
    end
  end

  def get_spot(board)
    best_move = nil
    available_spaces = board.spots.select { |s| s != 'X' && s != 'O' }

    available_spaces.each do |as|
      board.spots[as.to_i] = mark
      if board.game_over?
        best_move = as.to_i
        board.spots[as.to_i] = as
        return best_move
      else
        board.spots[as.to_i] = other_player_mark
        if board.game_over?
          best_move = as.to_i
          board.spots[as.to_i] = as
          return best_move
        else
          board.spots[as.to_i] = as
        end
      end
    end

    return best_move if best_move

    n = rand(0..available_spaces.count)
    available_spaces[n].to_i
  end

  private

  def other_player_mark
    mark == 'X' ? 'O' : 'X'
  end
end
