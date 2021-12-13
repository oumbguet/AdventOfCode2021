file = File.open("input", "r")
data = file.readlines.map(&:chomp)

require 'colorize'

class Paper
    attr_accessor :map, :width, :height

    def initialize(data)
        @width = data.sort_by { |x| x[0] }[-1][0]
        @height = data.sort_by { |x| x[1] }[-1][1]

        puts "Width: #{@width}"
        puts "Height: #{@height}"
        @map = Array.new(height + 1) { Array.new(width + 1, '.') }

        data.each do |row|
            x, y = row[0], row[1]
            @map[y][x] = '#'
        end
    end

    def dump
        puts ' '
        @map.each do |row|
            puts row.join
        end
        puts ' '
    end

    def fold_left(val)
        0.upto(@height) do |y|
            val.upto(@width) do |x|
                if @map[y][x] == '#'
                    @map[y][val - (x - val)] = '#'
                end
                @map[y][x] = '.'
            end
        end
    end

    def fold_up(val)
        val.upto(@height) do |y|
            0.upto(@width) do |x|
                if @map[y][x] == '#'
                    @map[val - (y - val)][x] = '#'
                end
                @map[y][x] = '.'
            end
        end
    end

    def folds(folds)
        folds.each do |fold|
            side, val = fold.split(' ')[2].split('=')
            
            if side == 'x'
                fold_left(val.to_i)
            else
                fold_up(val.to_i)
            end
        end
    end

    def count_dots
        @map.flatten.count('#')
    end
end

coordinates = data[0...data.index { |x| x.length == 0 }].map { |line| line.split(",").map(&:to_i) }
folds = data[(data.index { |x| x.length == 0 } + 1)..-1]

paper = Paper.new(coordinates)



paper.folds(folds)

puts "\nSecret password:\n".green
0.upto(5) do |i|
    0.upto(38) do |j|
        print paper.map[i][j] == '.' ? ' ' : '#'
    end
    puts
end