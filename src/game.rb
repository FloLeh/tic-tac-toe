require_relative 'board.rb'

class Game
  attr_reader :board

  PLAYER_1 = 'X'
  PLAYER_2 = 'O'

  def initialize
    @board = Board.new
  end

  def start_game
    puts " #{board_spots[0]} | #{board_spots[1]} | #{board_spots[2]} \n===+===+===\n #{board_spots[3]} | #{board_spots[4]} | #{board_spots[5]} \n===+===+===\n #{board_spots[6]} | #{board_spots[7]} | #{board_spots[8]} \n"
    puts "\nEnter [0-8]:\n"

    until game_over? || tie?
      choose_player_spot
      eval_board if !game_over? && !tie?
      puts " #{board_spots[0]} | #{board_spots[1]} | #{board_spots[2]} \n===+===+===\n #{board_spots[3]} | #{board_spots[4]} | #{board_spots[5]} \n===+===+===\n #{board_spots[6]} | #{board_spots[7]} | #{board_spots[8]} \n"
    end

    puts "\nGame over"
  end

  def choose_player_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if board_spots[spot] != 'X' && board_spots[spot] != 'O'
        board.choose_spot(spot, PLAYER_2)
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if board_spots[4] == '4'
        spot = 4
        board.choose_spot(spot, PLAYER_1)
      else
        spot = get_best_move(PLAYER_1)
        if board_spots[spot] != 'X' && board_spots[spot] != 'O'
          board.choose_spot(spot, PLAYER_1)
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

  private

  def game_over?
    [board_spots[0], board_spots[1], board_spots[2]].uniq.size == 1 ||
    [board_spots[3], board_spots[4], board_spots[5]].uniq.size == 1 ||
    [board_spots[6], board_spots[7], board_spots[8]].uniq.size == 1 ||
    [board_spots[0], board_spots[3], board_spots[6]].uniq.size == 1 ||
    [board_spots[1], board_spots[4], board_spots[7]].uniq.size == 1 ||
    [board_spots[2], board_spots[5], board_spots[8]].uniq.size == 1 ||
    [board_spots[0], board_spots[4], board_spots[8]].uniq.size == 1 ||
    [board_spots[2], board_spots[4], board_spots[6]].uniq.size == 1
  end

  def tie?
    board_spots.all? { |spot| spot == 'X' || spot == 'O' }
  end

  def board_spots
    board.spots
  end
end

game = Game.new
game.start_game
