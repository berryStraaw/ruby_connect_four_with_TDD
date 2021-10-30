class Player
    attr_reader :sign 
    attr_reader :name
    def initialize(name,sign)
        @name=name
        @sign=sign
    end
end