require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    tttn = TicTacToeNode.new(game.board, mark)
    non_losing = []
    tttn.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
      non_losing << child unless child.losing_node?(mark)
    end
    raise "Something is wrong" if non_losing.length == 0
    non_losing.sample.prev_move_pos
  end
  
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
