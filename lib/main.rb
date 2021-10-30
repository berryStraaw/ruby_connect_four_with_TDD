require_relative 'player'

class Board
    attr_accessor :board
    attr_reader :activePlayer
    attr_reader :nextPlayer

    def initialize()
        make_board
        p1=Player.new('Player1','X')
        p2=Player.new('Player2','O')
        @activePlayer=p2
        @nextPlayer=p1
    end

    def make_board()
        @board=[]
        6.times do |time|
            @board[time]=[]
            7.times do |col|
                @board[time][col]=""
            end
        end
    end

    def input()
        loop do
            user_input=gets.chomp.to_i
            return user_input if validate(user_input)
            puts "bad input"
        end
    end

    def validate(num)
        return num if num.between?(0,7) && @board[0][num]==""
    end

    def update(pos)
        added=false
        rows=5
        until added || rows<0
            if @board[rows][pos]==""
                @board[rows][pos]=@activePlayer.sign
                added=true
            else
                rows-=1
            end
        end
        if rows<0
            return false
        end
    end

    def winCheck()
        arr=@board
        aS=""
        arr.each_with_index do |row,row_i|
            row.each_with_index do |col,col_i|
                aS=col
                if aS==@activePlayer.sign || aS==@nextPlayer.sign
                    if col_i<4
                        if arr[row_i][col_i+1]==aS && arr[row_i][col_i+2]==aS && arr[row_i][col_i+3]==aS
                            return true
                        end
                    end
                    if row_i<3
                        if arr[row_i+1][col_i]==aS && arr[row_i+2][col_i]==aS && arr[row_i+3][col_i]==aS
                            return true
                        end
                    end
                    if row_i<3 && col_i<4
                        if arr[row_i+1][col_i+1]==aS && arr[row_i+2][col_i+2]==aS && arr[row_i+3][col_i+3]==aS
                            return true
                        end         
                    end
                    if row_i>2 && col_i<4
                        if arr[row_i-1][col_i+1]==aS && arr[row_i-2][col_i+2]==aS && arr[row_i-3][col_i+3]==aS
                            return true
                        end         
                    end
                end
            end
        end
        return false
    end

    def updateActivePlayer()
        temp=@activePlayer
                @activePlayer=@nextPlayer
                @nextPlayer=temp
    end

    def play()
        until winCheck()
            updateActivePlayer()
            puts "#{@activePlayer.name} please choose a column"
            user_input=input()
            update(user_input)
            display()
        end
        puts "#{@activePlayer.name} Wins"
    end

    def display()
        @board.each{|row| p row}
    end
end

board=Board.new()
board.display()
board.play()