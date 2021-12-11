file = File.open("input", "r")
data = file.readlines.map(&:chomp)

class Stack
    attr_accessor :data, :opening, :closing,
    :result

    def initialize
        @data = []
        @opening = ['(', '[', '{', '<']
        @closing = [')', ']', '}', '>']
        @result = []
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

    def end_line()
        @result = []

        @data.reverse.each do |el|
            @result.push(@closing[@opening.index(el)])
            @data.pop()
        end

        local_count = 0
        
        @result.each do |x|
            local_count *= 5

            local_count +=
                x == ')' ? 1
                : x == ']' ? 2
                : x == '}' ? 3
                : x == '>' ? 4 : 0
        end

        return local_count
    end
end

tmp_data = []

data.each do |line|
    stack = Stack.new()
    is_correct = true

    line.split('').each do |el|
        if !stack.push(el)
            is_correct = false
        end
    end
    if is_correct
        tmp_data.push(line)
    end
end

# puts tmp_data

counts = []

tmp_data.each do |line|
    stack = Stack.new()
    
    line.split('').each do |el|
        stack.push(el)
    end
    counts.push(stack.end_line())
end

puts counts.sort[counts.sort.length / 2]