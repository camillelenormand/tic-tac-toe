# Require the bundler gem and load all dependencies
require 'bundler'
Bundler.require

# Require the display module
require_relative "lib/display"
require_relative "lib/player"
require_relative "lib/board"
require_relative "lib/game"

# Define the Game class
class Game
  # Include the Display module
  include Display

  # Initialize the game
  def initialize 
    # Display the game banner
    display_banner
    # Prompt the first player to enter their name
    display_player_name_prompt
    # Get the first player's name from the user
    @player1 = gets.chomp
    # Prompt the first player to enter their symbol
    display_player_symbol_prompt
    # Get the first player's symbol from the user
    @symbol1 = gets.chomp.upcase
    # Prompt the second player to enter their name
    display_player_name_prompt
    # Get the second player's name from the user
    @player2 = gets.chomp
    # Prompt the second player to enter their symbol
    display_player_symbol_prompt
    # Get the second player's symbol from the user
    @symbol2 = gets.chomp.upcase
    # Create a new 3x3 board
    @board = Array.new(3) { Array.new(3, " ") }
    Player.new(@player1, @symbol1)
    Player.new(@player2, @symbol2)
    display_welcome(@player1, @player2)
  end

  # Display the game board
  def display_board
    puts <<-HEREDOC
    \e[1;94m
       ---+---+---
      | #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |
       ---+---+---
      | #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |
       ---+---+---
      | #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |
       ---+---+---
    \e[0m
    HEREDOC
  end

  # Make a move on the board
  def make_move(player, symbol)
    # Prompt the player to enter their move
    puts "#{player}, it's your turn! (#{symbol}). Enter your move (row, column): "
    # Get the player's move from the user
    row, col = gets.chomp.split(",").map(&:to_i)
    # Check if the move is valid
    if @board[row][col] == " "
      # Update the board with the player's move
      @board[row][col] = symbol
    else
      # If the move is invalid, prompt the player to try again
      puts "Invalid move. Please try again."
      make_move(player, symbol)
    end
  end

  # Check if the game is over
  def game_over
    # Are all elements in a row of the game board the same?
    @board.each do |row|
      if row.uniq.length == 1 && row[0] != " "
        return row[0]
      end
    end

    # Are all elements in a column of the game board the same?
    @board.transpose.each do |col|
      if col.uniq.length == 1 && col[0] != " "
        return col[0]
      end
    end

    # Are all elements in a diagonal of the game board the same?
    # Right diagonal?
    if [@board[0][0], @board[1][1], @board[2][2]].uniq.length == 1 && @board[0][0] != " "
      return @board[0][0]
    end
    # Left diagonal?
    if [@board[0][2], @board[1][1], @board[2][0]].uniq.length == 1 && @board[0][2] != " "
      return @board[0][2]
    end

    # Check for tie
    # Are all the cells on the board are filled with either "X" or "O"?
    if @board.flatten.none? { |cell| cell == " " }
      return "Tie"
    end

    # Game is not over yet
    return false
  end

  # Play the game
  def play
    # Set the current player and symbol
    current_player = @player1
    current_symbol = @symbol1
    # Loop until the game is over
    until game_over
      # Display the game board
      display_board
      # Make a move for the current player
      make_move(current_player, current_symbol)
      # Switch to the other player
      current_player, current_symbol = current_symbol == @symbol1 ? [@player2, @symbol2] : [@player1, @symbol1]
    end
    # Display the final game board
    display_board
    # Determine the winner
    winner = game_over
    # Display the winner or a tie message
    if winner == "Tie"
      puts "It's a tie!"
    else
      puts "#{winner} wins!"
    end
  end
  
end

# Create a new game and play it
game = Game.new
game.play
