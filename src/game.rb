require_relative 'board'
require_relative 'players/human'
require_relative 'players/computer'
require_relative '../lib/input_validator'

class Game
  include InputValidator

  attr_reader :board, :player1, :player2

  def self.start
    new.start
  end

  def initialize
    @board = Board.new
  end

  def start
    puts "Let the game begin"
    game_type = choose_game_type
    board.print_current_board_state

    case game_type
    when :cc
      @player1 = Computer.new('O')
      @player2 = Computer.new('X')
      computer_vs_computer_game
    when :hh
      @player1 = Human.new('O')
      @player2 = Human.new('X')
      player_vs_player_game
    when :hc
      @player1 = Human.new('O')
      @player2 = Computer.new('X', choose_game_level)
      computer_vs_player_game
    end

    puts "\nGame over"
  end

  def computer_vs_computer_game
    until board.game_over? || board.tie?
      player1.choose_spot(board)
      player2.choose_spot(board) if !board.game_over? && !board.tie?
      board.print_current_board_state
    end
  end

  def player_vs_player_game
    until board.game_over? || board.tie?
      player1.choose_spot(board)
      player2.choose_spot(board) if !board.game_over? && !board.tie?
      board.print_current_board_state
    end
  end

  def computer_vs_player_game
    until board.game_over? || board.tie?
      player1.choose_spot(board)
      player2.choose_spot(board) if !board.game_over? && !board.tie?
      board.print_current_board_state
    end
  end
end
