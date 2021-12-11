file = File.open("input", "r")
data = file.readlines.map(&:chomp)

class Stack
    attr_accessor :data, :opening, :closing

    def initialize
        @data = []
        @opening = ['(', '[', '{', '<']
        @closing = [')', ']', '}', '>']
    end

    def push(el)
        if @opening.include?(el)
            @data.push(el)
        elsif @closing.include?(el)
            if (@opening[@closing.index(el)] == data[-1])
                data.pop()
            else
                return false
            end
        end
        return true
    end
end


count = 0

data.each do |line|
    stack = Stack.new()
    line.split('').each do |el|
        if !stack.push(el)
            count += el == ')' ? 3
                : el == ']' ? 57
                : el == '}' ? 1197
                : el == '>' ? 25137
                : 0
            break
        end
    end
end

puts count