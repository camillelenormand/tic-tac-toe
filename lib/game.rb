class Game
  include Display

  def initialize
    display_banner
    display_player_name_prompt
    @player1 = Player.new(gets.chomp, gets.chomp.upcase)
    display_player_name_prompt
    @player2 = Player.new(gets.chomp, gets.chomp.upcase)
    @board = Board.new
    display_welcome(@player1.name, @player2.name)
  end

  def play
    # Set the current player and symbol
    current_player = @player1
    current_symbol = @player1.symbol
    until @board.game_over
      @board.display_board
      puts "#{current_player.name}, it's your turn! (#{current_symbol}). Enter your move (row, column): "
      row, col = gets.chomp.split(",").map(&:to_i)
      if @board.make_move(row, col, current_symbol)
        current_player, current_symbol = current_symbol == @player1.symbol ? [@player2, @player2.symbol] : [@player1, @player1.symbol]
      else
        puts "Invalid move. Please try again."
      end
    end
    @board.display_board
    winner = @board.game_over
    if winner == "Tie"
      puts "It's a tie!"
    else
      puts "#{winner} wins!"
    end
  end
end