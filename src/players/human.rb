require_relative 'player'

class Human < Player
  def choose_player_spot(board)
    spot = get_spot(board)
    board.choose_spot(spot, mark)
  end

  def get_spot(board)
    puts "Enter [0-8]:\n"
    spot = gets.chomp
    spot = spot.to_i if from_zero_to_eight?(spot)

    while !spot.is_a?(Integer) || board.chosen_spot?(spot)
      puts "\nYou entered '#{spot}'. Enter [0-8]:\n"
      spot = gets.chomp
      spot = spot.to_i if from_zero_to_eight?(spot)
    end

    spot
  end

  private

  def from_zero_to_eight?(spot)
    spot == '0' ||
      spot == '1' ||
      spot == '2' ||
      spot == '3' ||
      spot == '4' ||
      spot == '5' ||
      spot == '6' ||
      spot == '7' ||
      spot == '8'
  end
end
