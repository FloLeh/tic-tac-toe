module InputValidator
  def choose_game_type
    puts "Choose the game type:"
    puts "'cc' for computer vs computer"
    puts "'hh' for human vs human"
    puts "'hc' for human vs computer"
    game_type = gets.chomp

    while wrong_game_type(game_type)
      puts "\nYou entered '#{game_type}'. Choose these game type::\n"
      puts "'cc' for computer vs computer"
      puts "'hh' for human vs human"
      puts "'hc' for computer vs human"
      game_type = gets.chomp
    end

    game_type.to_sym
  end

  private

  def wrong_game_type(game_type)
    game_type != 'cc' &&
    game_type != 'hh' &&
    game_type != 'hc'
  end
end
