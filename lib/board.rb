class Board
  attr_reader :board

  def initialize
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

  def make_move(row, col, symbol)
    if @board[row][col] == " "
      @board[row][col] = symbol
      return true
    else
      return false
    end
  end

  def game_over
    @board.each do |row|
      if row.uniq.length == 1 && row[0] != " "
        return row[0]
      end
    end
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
end