file = File.open("input", "r")
data = file.readlines.map(&:chomp)

class VentLine
    attr_accessor :x, :y, :is_straight

    def initialize(line)
        splitted = line.split(' -> ')
        first, second = splitted[0].split(',').map(&:to_i), splitted[1].split(',').map(&:to_i)
        @x = [first[0], second[0]]
        @y = [first[1], second[1]]
        @is_straight = @x[0] == @x[1] || @y[0] == @y[1]

        # If running backwards, swap the x and y values
        if @is_straight
            if @x[0] > @x[1]
                @x[0], @x[1] = @x[1], @x[0]
            end
            if @y[0] > @y[1]
                @y[0], @y[1] = @y[1], @y[0]
            end
        end
    end

    def dump
        puts "\n(#{@x[0]}, #{@y[0]}) -> (#{@x[1]}, #{@y[1]})"
        puts "is_straight: #{@is_straight}"
    end
end

class Map
    attr_accessor :lines

    def initialize(width, height)
        @lines = Array.new(height) { Array.new(width, 0) }
    end

    def dump
        puts "\nMap:"
        @lines.each do |line|
            puts line.map { |x| x == 0 ? '.' : x }.join('')
        end
    end

    def draw_diagonal(line)
        x_range = line.x[0].step(line.x[1], line.x[0] < line.x[1] ? 1 : -1).to_a
        y_range = line.y[0].step(line.y[1], line.y[0] < line.y[1] ? 1 : -1).to_a
        
        0.upto(x_range.count - 1) do |i|
            @lines[y_range[i]][x_range[i]] += 1
        end

    end

    def addLine(line)
        if line.is_straight
            if line.x[0] == line.x[1]
                line.y[0].upto(line.y[1]) do |y|
                    @lines[y][line.x[0]] += 1
                end
            elsif line.y[0] == line.y[1]
                line.x[0].upto(line.x[1]) do |x|
                    @lines[line.y[0]][x] += 1
                end
            end
        else
            draw_diagonal(line)
        end
    end

    def count_dangerous_spots()
        count = 0
        @lines.each do |line|
            line.each do |spot|
                count += 1 if spot >= 2
            end
        end
        count
    end
end

# Create ventlines array from file input data
ventlines = []
data.each do |line|
    ventlines << VentLine.new(line)
end

# Create empty map
map = Map.new(1000, 1000)

# Draw lines into map
ventlines.each do |line|
    map.addLine(line)
end


map.dump()

puts "Dangerous spots: #{map.count_dangerous_spots()}"