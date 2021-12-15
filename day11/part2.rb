file = File.open("input", "r")
data = file.readlines.map(&:chomp).map { |line| line.split("").map(&:to_i) }

require 'colorize'

class Octopuses
    attr_accessor :grid, :step

    def initialize(data)
        @grid = data
        @step = 0
    end

    def increase_all_by_one
        0.upto(@grid.length - 1) do |y|
            0.upto(@grid[0].length - 1) do |x|
                if @grid[y][x] == 9
                    @grid[y][x] = 0
                else
                    @grid[y][x] += 1
                end
            end
        end
    end

    def flash_other(x, y)
        to_flash = []
        # left
        if x > 0 && @grid[y][x - 1] > 0
            if @grid[y][x - 1] == 9
                @grid[y][x - 1] = 0
                to_flash << [x - 1, y]
            else
                @grid[y][x - 1] += 1
            end
        end
        # right
        if x < @grid[0].length - 1 && @grid[y][x + 1] > 0
            if @grid[y][x + 1] == 9
                @grid[y][x + 1] = 0
                to_flash << [x + 1, y]
            else
                @grid[y][x + 1] += 1
            end
        end
        # up
        if y > 0 && @grid[y - 1][x] > 0
            if @grid[y - 1][x] == 9
                @grid[y - 1][x] = 0
                to_flash << [x, y - 1]
            else
                @grid[y - 1][x] += 1
            end
        end
        # down
        if y < @grid.length - 1 && @grid[y + 1][x] > 0
            if @grid[y + 1][x] == 9
                @grid[y + 1][x] = 0
                to_flash << [x, y + 1]
            else
                @grid[y + 1][x] += 1
            end
        end

        # up left
        if x > 0 && y > 0 && @grid[y - 1][x - 1] > 0
            if @grid[y - 1][x - 1] == 9
                @grid[y - 1][x - 1] = 0
                to_flash << [x - 1, y - 1]
            else
                @grid[y - 1][x - 1] += 1
            end
        end
        # up right
        if x < @grid[0].length - 1 && y > 0 && @grid[y - 1][x + 1] > 0
            if @grid[y - 1][x + 1] == 9
                @grid[y - 1][x + 1] = 0
                to_flash << [x + 1, y - 1]
            else
                @grid[y - 1][x + 1] += 1
            end
        end
        # down left
        if x > 0 && y < @grid.length - 1 && @grid[y + 1][x - 1] > 0
            if @grid[y + 1][x - 1] == 9
                @grid[y + 1][x - 1] = 0
                to_flash << [x - 1, y + 1]
            else
                @grid[y + 1][x - 1] += 1
            end
        end
        # down right
        if x < @grid[0].length - 1 && y < @grid.length - 1 && @grid[y + 1][x + 1] > 0
            if @grid[y + 1][x + 1] == 9
                @grid[y + 1][x + 1] = 0
                to_flash << [x + 1, y + 1]
            else
                @grid[y + 1][x + 1] += 1
            end
        end


        
        to_flash.each do |x, y|
            flash_other(x, y)
        end

    end

    def check_flashes
        to_flash = []
        count = 0

        0.upto(@grid.length - 1) do |y|
            0.upto(@grid[0].length - 1) do |x|
                if @grid[y][x] == 0
                    to_flash << [x, y]
                    count += 1
                end
            end
        end

        to_flash.each do |x, y|
            flash_other(x, y)
        end
    end

    def count_zeros
        count = 0
        0.upto(@grid.length - 1) do |y|
            0.upto(@grid[0].length - 1) do |x|
                if @grid[y][x] == 0
                    count += 1
                end
            end
        end
        count
    end

    def simulate()
        @step += 1
        increase_all_by_one()
        check_flashes()
        count = count_zeros()

        if count == 100
            puts @step
            return true
        end
        return false
    end

    def dump_grid()
        @grid.each do |row|
            row.each do |cell|
                print cell == 0 ? cell.to_s.colorize(:red) : cell
                print ' '
            end
            puts ''
        end
        puts ''
    end
end

octo = Octopuses.new(data)
count = 0

while !octo.simulate()
end

octo.dump_grid()