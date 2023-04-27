require 'bundler'
Bundler.require

require_relative "lib/display"

class Game
  include Display

  def initialize 
    display_banner
    display_player_name_prompt
    @player1 = gets.chomp
    display_player_symbol_prompt
    @symbol1 = gets.chomp.upcase
    display_player_name_prompt
    @player2 = gets.chomp
    display_player_symbol_prompt
    @symbol2 = gets.chomp.upcase
    display_welcome(@player1, @player2)
    @board = Array.new(3) { Array.new(3, " ") }
  end

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

  def make_move(player, symbol)
    puts "#{player}, it's your turn (#{symbol}). Enter your move (row, column): "
    row, col = gets.chomp.split(",").map(&:to_i)
    if @board[row][col] == " "
      @board[row][col] = symbol
    else
      puts "Invalid move. Please try again."
      make_move(player, symbol)
    end
  end

  def game_over
    # Check rows
    @board.each do |row|
      if row.uniq.length == 1 && row[0] != " "
        return row[0]
      end
    end

    # Check columns
    @board.transpose.each do |col|
      if col.uniq.length == 1 && col[0] != " "
        return col[0]
      end
    end

    # Check diagonals
    if [@board[0][0], @board[1][1], @board[2][2]].uniq.length == 1 && @board[0][0] != " "
      return @board[0][0]
    end
    if [@board[0][2], @board[1][1], @board[2][0]].uniq.length == 1 && @board[0][2] != " "
      return @board[0][2]
    end

    # Check for tie
    if @board.flatten.none? { |cell| cell == " " }
      return "Tie"
    end

    # Game is not over yet
    return false
  end

  def play
    current_player = @player1
    current_symbol = @symbol1
    until game_over
      display_board
      make_move(current_player, current_symbol)
      current_player, current_symbol = current_symbol == @symbol1 ? [@player2, @symbol2] : [@player1, @symbol1]
    end
    display_board
    winner = game_over
    if winner == "Tie"
      puts "It's a tie!"
    else
      puts "#{winner} wins!"
    end
  end
  
end

game = Game.new
game.play

