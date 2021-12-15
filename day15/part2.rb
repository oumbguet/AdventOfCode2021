file = File.open("input", "r")
data = file.readlines.map(&:chomp).map { |line| line.split("").map(&:to_i) }

require 'colorize'
require 'pqueue'
require 'set'

def solve(data)
    height = data.length
    width = data[0].length

    queue = PQueue.new([[0, [0, 0]]]) { |a, b| a.first < b.first }
    visited = Set[]

    while !queue.empty?
        current = queue.pop

        visited.add(current[1])
        if current[1] == [width - 1, height - 1]
            return current
        end

        for c in [[-1, 0], [0, 1], [1, 0], [0, -1]]
            coord = [current[1][0] + c[0], current[1][1] + c[1]]

            if !visited.include?(coord) && coord[0] >= 0 && coord[0] < width && coord[1] >= 0 && coord[1] < height
                visited << coord
                queue.push([current[0] + data[coord[0]][coord[1]], coord])
            end
        end
    end
end

def create_new_map(data)
    new_data = Array.new(data.length) { Array.new(data[0].length * 5, 0) }
    
    data.each_with_index do |line, y|
        line.each_with_index do |value, x|
            0.upto(4) do |i|
                new_data[y][x + data[0].length * i] = value + i > 9 ? value + i - 9 : value + i
            end
        end
    end

    data = new_data

    new_data = Array.new(data.length * 5) { Array.new(data[0].length, 0) }

    data.each_with_index do |line, y|
        line.each_with_index do |value, x|
            0.upto(4) do |i|
                new_data[y + data.length * i][x] = value + i > 9 ? value + i - 9 : value + i
            end
        end
    end
    
    return new_data
end

def dump_map(data)
    data.each do |line|
        puts line.join(" ")
    end
end

data = create_new_map(data)

result = solve(data)

# puts result

puts "Result: #{result[0]}".colorize(:red)
puts "Coord: #{result[1][0]}, #{result[1][1]}".green