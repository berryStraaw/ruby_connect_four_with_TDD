require_relative '../lib/main'

describe Board do
    
    subject(:board){described_class.new()}
    
    desired_board=[
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','','','','']
    ]

    it "makes a clean board" do
        expect(board.board).to eq(desired_board)
    end

    describe "player input" do

        subject(:game_input){described_class.new()}

        context "when input is valid" do
            before do
                valid_input='3'
                allow(game_input).to receive(:gets).and_return(valid_input)
            end

            it "takes in valid input" do
                error_message="bad input"
                expect(game_input).not_to receive(:puts).with(error_message)
                game_input.input()
            end

        end

        context "when input is incorect once" do
            before do
                valid_input='3'
                allow(game_input).to receive(:gets).and_return('8',valid_input)
            end
            it "returns one error, before valid input" do
                error_message="bad input"
                expect(game_input).to receive(:puts).with(error_message).once
                game_input.input()
            end
        end
        context 'check validation' do
            it 'with valid input'do
                expect(game_input.validate(0)).to eq(0)
            end
            it 'with out of board value'do
                expect(game_input.validate(-1)).to be_nil
            end
            it 'with out of board value 8'do
                expect(game_input.validate(8)).to be_nil
            end
        end
    end
    describe "board update" do
        subject(:game_update){described_class.new()}
        context 'update on empty board' do
            updated_board=[
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','X','','','']
            ]
            before do
                game_update.update(3)
            end
            it 'valid update' do
                expect(game_update.board).to eq(updated_board)
            end
        end
        context 'update on second player' do
            updated_board=[
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','X','O','','']
            ]
            before do
                game_update.update(3)
                game_update.update(4)
            end
            it 'valid update' do
                expect(game_update.board).to eq(updated_board)
            end
        end
        context 'update on second player stacked' do
            updated_board=[
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','','','',''],
            ['','','','O','','',''],
            ['','','','X','','','']
            ]
            before do
                game_update.update(3)
                game_update.update(3)
            end
            it 'valid update' do
                expect(game_update.board).to eq(updated_board)
            end
        end
        context 'update on max stacks and beyond' do
            updated_board=[
            ['','','','O','','',''],
            ['','','','X','','',''],
            ['','','','O','','',''],
            ['','','','X','','',''],
            ['','','','O','','',''],
            ['','','','X','','','']
            ]
            before do
                game_update.update(3)
                game_update.update(3)
                game_update.update(3)
                game_update.update(3)
                game_update.update(3)
                game_update.update(3)
                game_update.update(3)
                game_update.update(3)
            end
            it 'valid update' do
                expect(game_update.board).to eq(updated_board)
            end
        end
    end
    describe "win check" do
        subject(:win_board){described_class.new()}
        winning_board=[
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','','','',''],
        ['X','X','X','X','','','X']
        ]
        winning_board2=[
        ['','','','','','',''],
        ['','','','','','',''],
        ['X','','','','','',''],
        ['X','','','','','',''],
        ['X','','','','','',''],
        ['X','X','O','O','','','X']
        ]
        winning_board3=[
        ['O','','','','','',''],
        ['','O','','','','',''],
        ['','','O','','','',''],
        ['','','','O','','',''],
        ['','','','','','',''],
        ['X','X','O','X','','','X']
        ]
        winning_board4=[
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','X','','',''],
        ['','','','','X','',''],
        ['','','','','','X',''],
        ['X','X','O','X','','','X']
        ]
        
        context "checking valid victory" do
            before do
                win_board.board=winning_board
            end
            it "basic check 1" do
                expect(win_board.winCheck).to be(true)
            end

            before do
                win_board.board=winning_board2
            end
            it "basic check 2" do
                expect(win_board.winCheck).to be(true)
            end

            before do
                win_board.board=winning_board3
            end
            it "basic check 3" do
                expect(win_board.winCheck).to be(true)
            end

            before do
                win_board.board=winning_board4
            end
            it "basic check 4" do
                expect(win_board.winCheck).to be(true)
            end
        end

        loosing_board=[
        ['X','','','X','','',''],
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','','','',''],
        ['X','X','O','X','','','']
        ]
        loosing_board2=[
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','X','','',''],
        ['','','','','X','',''],
        ['','','X','X','','O',''],
        ['X','X','O','X','','','X']
        ]
        loosing_board3=[
        ['','','','','','',''],
        ['','','','','','',''],
        ['O','','','X','','',''],
        ['X','','','','X','',''],
        ['X','','','','O','O',''],
        ['X','X','O','X','','','X']
        ]
        loosing_board4=[
        ['','','','','','',''],
        ['','','','','','',''],
        ['','','','X','','O',''],
        ['','','','','X','O',''],
        ['','','','','','O','O'],
        ['X','X','O','X','','','X']
        ]
        context "checking for false victories" do
            before do
                win_board.board=loosing_board
            end
            it "basic check 1" do
                expect(win_board.winCheck).not_to be(true)
            end

            before do
                win_board.board=loosing_board2
            end
            it "basic check 2" do
                expect(win_board.winCheck).not_to be(true)
            end

            before do
                win_board.board=loosing_board3
            end
            it "basic check 3" do
                expect(win_board.winCheck).not_to be(true)
            end

            before do
                win_board.board=loosing_board4
            end
            it "basic check 4" do
                expect(win_board.winCheck).not_to be(true)
            end


        end
    end
end