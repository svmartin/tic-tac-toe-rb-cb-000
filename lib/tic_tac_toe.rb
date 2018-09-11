WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n"
  puts "-----------\n"
  puts " #{board[3]} | #{board[4]} | #{board[5]} \n"
  puts "-----------\n"
  puts " #{board[6]} | #{board[7]} | #{board[8]} \n"
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def won?(board)
  winner_exist = false
  return false if board.all? { |entry| entry == " "}

  WIN_COMBINATIONS.each do |winner|
    row = [board[winner[0]], board[winner[1]], board[winner[2]]]
    return winner if row.count("X") == 3 || row.count("O") == 3
  end
  winner_exist
end

def full?(board)
  board.count == 9 && board.include?("X") && !board.include?(" ")
end

def draw?(board)
  return true if !won?(board) && full?(board)
  return false
end

def player_move(board, move, character)
  board[move] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, position)
  !position_taken?(board, position) && position >= 0 and position <= 8
end

def turn_count(board)
  total = 0
  total += board.count("X")
  total += board.count("O")
  total
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end


def turn(board)
  puts "Please enter 1-9"
  user_move = gets.strip
  user_move = input_to_index(user_move)
  if valid_move?(board, user_move)
    player_move(board, user_move, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def over?(board)
  won?(board) || full?(board) || draw?(board) ? true : false
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  else
    return nil
  end
end

def play
  while !over?(board)
    turn(board)
  end
  puts "Game over!"
end
