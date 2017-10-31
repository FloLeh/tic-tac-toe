class Game
  attr_reader :board, :computer, :human

  def initialize
    @board = ['0', '1', '2', '3', '4', '5', '6', '7', '8']
    @computer = 'X'
    @human = 'O'
  end

  def start_game
    puts " #{board[0]} | #{board[1]} | #{board[2]} \n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]} \n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]} \n"
    puts "\nEnter [0-8]:\n"

    until game_over?(board) || tie?(board)
      get_human_spot
      eval_board if !game_over?(board) && !tie?(board)
      puts " #{board[0]} | #{board[1]} | #{board[2]} \n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]} \n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]} \n"
    end

    puts "\nGame over"
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if board[spot] != 'X' && board[spot] != 'O'
        board[spot] = human
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if board[4] == '4'
        spot = 4
        board[spot] = computer
      else
        spot = get_best_move(board, computer)
        if board[spot] != 'X' && board[spot] != 'O'
          board[spot] = computer
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil

    board.each do |s|
      available_spaces << s if s != 'X' && s != 'O'
    end

    available_spaces.each do |as|
      board[as.to_i] = computer
      if game_over?(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = human
        if game_over?(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end

    return best_move if best_move

    n = rand(0..available_spaces.count)
    available_spaces[n].to_i
  end

  def game_over?(board)
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def tie?(board)
    board.all? { |cell| cell == 'X' || cell == 'O' }
  end
end

game = Game.new
game.start_game
