file = File.open("test_input", "r")
data = file.readlines.map(&:chomp)

class Line
  attr_accessor :digits, :outputs, :sides

  def initialize(line)
    splitted = line.split(" |")

    @digits = splitted[0].split(" ")
    @outputs = splitted[1].split(" ")
    @sides = Array.new(7) {''}
  end

  def dump
    puts "digits: #{@digits}"
    puts "outputs: #{@outputs}"
    puts "sides: #{@sides}"
  end

  def get_digit_by_length(length)
    @digits.each do |digit|
        return digit if digit.length == length
    end
    return nil
  end

  def set_sides
    var1 = get_digit_by_length(2)
    sides[2], sides[5] = var1[0], var1[1]

    var4 = get_digit_by_length(4)
    sides[1], sides[3], sides[5] = var4[0], var4[2], var4[3]

    var7 = get_digit_by_length(3)
    puts var7
    sides[0] = var7[0]

    var8 = get_digit_by_length(7)
    puts var8
    sides[4], sides[6] = var8[4], var8[6]
  end

end

lines = data.map { |line| Line.new(line) }



lines[0].set_sides()
lines[0].dump()