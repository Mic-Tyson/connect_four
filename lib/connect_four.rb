class Connect_four
  ROWS = 6
  COLUMNS = 7
  PIECE1 = 'X'
  PIECE2 = 'O'
  EMPTY = ' '
  TRANSFORMATIONS = [
    # verticals
    [0][0], [1][0], [2][0], [3][0]

  ]
  
  attr_reader :player_turn

  def initialize
    @board = []
    ROWS.times do
      row = []
      COLUMNS.times { row << EMPTY }
      @board << row
    end

    @player_turn = 1
    @last_move_row = nil
    @last_move_column = nil
  end

  def get(x, y)
    @board[y-1][x-1]
  end

  def place_piece(x)
    x -= 1
    y = column_space(x)

    return nil if y.negative?

    piece = player_turn
    change_turn

    @board[y][x] = piece
    @last_move_row = y
    @last_move_column = x
  end

  def change_turn
    return @player_turn = 2 if @player_turn == 1

    @player_turn = 1
  end

  def verify_input(y)
    y = y.to_i
    y.between?(1, 7)
  end

  def game_over?
    check = @player_turn
    if check == 1
      check = 2
    else
      check = 1
    end
    @board[0].none?(EMPTY) || win_check(check.to_s)
  end

  def win_check(piece)
    check_horizontal(piece) ||
      check_vertical(piece) ||
      check_diagonal(piece)
  end

  def final_message
    'Game Over!'
  end

  def play_game
    puts 'Let\'s play Connect Four'
    turn_loop until game_over?
    puts final_message
  end

  # recursive - assume plr wont keep making bad input
  def turn_loop
    column = player_input

    turn_loop if place_piece(column).nil?
    display
  end

  def display
    # Display the board
    @board.each do |row|
      puts "| " + row.join(" | ") + " |"
      puts "-" * (COLUMNS * 4 + 1)
    end

    # Display column numbers for easy reference
    puts "  " + (1..COLUMNS).to_a.join("   ")
  end

  private

  def column_space(x)
    y = @board.length - 1
    y -= 1 while @board[y][x] != EMPTY && y >= 0
    y
  end

  def player_input
    input = gets.chomp until verify_input(input)
    return input.to_i
  end


  def check_horizontal(piece)
    @board.any? do |row|
      row.join.include?(piece * 4)
    end
  end

  def check_vertical(piece)
    (0...COLUMNS).any? do |col|
      column_pieces = @board.map { |row| row[col] }.join
      column_pieces.include?(piece * 4)
    end
  end

  def check_diagonal(piece)
    check_diagonal_down(piece) || check_diagonal_up(piece)
  end

  def check_diagonal_down(piece)
    (0..(ROWS - 4)).each do |row|
      (0..(COLUMNS - 4)).each do |col|
        return true if (0..3).all? { |i| @board[row + i][col + i] == piece }
      end
    end
    false
  end

  def check_diagonal_up(piece)
    (3...ROWS).each do |row|
      (0..(COLUMNS - 4)).each do |col|
        return true if (0..3).all? { |i| @board[row - i][col + i] == piece }
      end
    end
    false
  end
end


=begin
def check_verticals
  x = @last_move_column
  y = @last_move_row

  # when y = 0, 1
  # when y = 1, 1, 2
  # when y = 2, 1, 2, 3
  # when y = 3,    2, 3, 4
  # when y = 4,       3, 4
  # when y = 5,          4

  case y
  when 0
  when 1
  when 2
  when 3
  when 4
  when 5

  end

  # when 0 <= y < 3

  # when 3 < y < 5 

  @board[y][x] && @board[y-1][x] && @board[y-2][x] && @board[y-3][x]
end
=end