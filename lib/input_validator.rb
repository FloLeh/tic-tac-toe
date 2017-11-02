module InputValidator
  def choose_game_type
    puts "Choose the game type:"
    puts "'cc' for computer vs computer"
    puts "'pp' for player vs player"
    puts "'cp' for computer vs player"
    game_type = gets.chomp

    while wrong_game_type(game_type)
      puts "\nYou entered '#{game_type}'. Choose these game type::\n"
      puts "'cc' for computer vs computer"
      puts "'pp' for player vs player"
      puts "'cp' for computer vs player"
      game_type = gets.chomp
    end

    game_type.to_sym
  end

  def get_spot_from_player
    puts "Enter [0-8]:\n"
    spot = gets.chomp
    spot = spot.to_i if from_zero_to_eight?(spot)

    while !spot.is_a?(Integer) || chosen_spot?(spot)
      puts "\nYou entered '#{spot}'. Enter [0-8]:\n"
      spot = gets.chomp
      spot = spot.to_i if from_zero_to_eight?(spot)
    end

    spot
  end

  private

  def wrong_game_type(game_type)
    game_type != 'cc' &&
    game_type != 'pp' &&
    game_type != 'cp'
  end

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
