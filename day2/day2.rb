file = File.open("input", "r")

data = file.readlines.map(&:chomp)

# Object with two vars depth and position
class Submarine
    attr_accessor :depth, :position
    
    def initialize(depth, position, aim)
        @depth = depth
        @position = position
        @aim = aim
    end

    def move(line)
        cmd, num = line.split(" ")
        num = num.to_i

        if cmd == "forward"
            @position += num
            @depth += @aim * num
        elsif cmd == "down"
            @aim += num
        elsif cmd == "up"
            @aim -= num
        end
    end
end

submarine = Submarine.new(0, 0, 0)

data.each do |line|
    submarine.move(line)
end

puts "position: #{submarine.position.abs.to_s}, depth: #{submarine.depth.abs.to_s}"
puts "Product: #{submarine.position.abs * submarine.depth.abs}"