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

  private

  def wrong_game_type(game_type)
    game_type != 'cc' &&
    game_type != 'pp' &&
    game_type != 'cp'
  end
end
