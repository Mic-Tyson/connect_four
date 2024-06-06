require_relative '../lib/connect_four.rb'

describe Connect_four do

  subject(:board) { described_class.new }
  describe '#place_piece' do
    empty = ' '

    it 'Empty board to bottom right' do
      board.place_piece(7)
      piece = board.get(7,6)
      expect(piece).not_to eq(empty)
    end

    it 'If space is not empty, places above' do
      2.times { board.place_piece(7) }
      piece = board.get(7, 5)
      expect(piece).not_to eq(empty)
    end

    it 'If there\'s no empty space, return nil' do
      6.times { board.place_piece(7) }
      expect(board.place_piece(7)).to be(nil)
    end

    it 'Edge case when only 1 space left' do
      6.times { board.place_piece(7) }
      piece = board.get(7,1)
      expect(piece).not_to eq(empty)
    end
  end

  describe '#change_turn' do
    it 'Initially should start with player 1' do
      player = board.instance_variable_get(:@player_turn)
      expect(player).to eq(1)
    end

    it 'Changing once should get to player 2' do
      board.change_turn
      player = board.instance_variable_get(:@player_turn)
      expect(player).to eq(2)
    end

    it 'Changing twice should get to player 1' do
      2.times { board.change_turn }
      player = board.instance_variable_get(:@player_turn)
      expect(player).to eq(1)
    end

    it 'Changing n times should get to player n%2 + 1' do
      12.times { board.change_turn }
      player = board.instance_variable_get(:@player_turn)
      expect(player).to eq(1)
    end
  end

  describe '#place_piece with turn order' do
    it 'Place 1 when player 1' do
      board.place_piece(7)
      piece = board.get(7, 6)
      expect(piece).to eq(1)
    end

    it 'Place 2 when player 2' do
      2.times { board.place_piece(7) }
      piece = board.get(7, 5)
      expect(piece).to eq(2)
    end
  end

  describe '#verify_input' do
    context 'when given a valid input as argument' do
      it 'returns true' do
        user_input = '3'
        verified_input = board.verify_input(user_input)
        expect(verified_input).to eq(true)
      end
    end

    context 'when given an invalid input as argument' do
      it 'returns false' do
        user_input = 'a'
        verified_input = board.verify_input(user_input)
        expect(verified_input).to eq(false)
      end
    end
    
  end

end
