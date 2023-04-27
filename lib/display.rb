# lib/display.rb
module Display

  def display_banner
    puts " -------------------------------------------------------- "
    puts "|                                                        |"
    puts "|           Welcome to the Tic Tac Toe game!             |"
    puts "|                                                        |"
    puts " -------------------------------------------------------- "
  end

  def display_player_name_prompt
    puts "Enter the name of the player:"
  end

  def display_player_symbol_prompt
    puts "Please select your symbol (X or O):"
  end

  def display_welcome(player1, player2)
    puts "Welcome #{player1} & #{player2}. Let's play!"
  end

  def display_player_turn_prompt(name, symbol)
    puts "Your turn #{name}! Choose one of the remaining cases..."
  end

  def display_winner(player)
    puts "GAME OVER! #{player} is the winner!"
  end

  def display_draw
    puts "It's a draw hahaha."
  end

end