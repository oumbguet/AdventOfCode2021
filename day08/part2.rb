file = File.open("input", "r")
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

  def get_set_by_length(length)
    @digits.each do |digit|
        return digit.split('').to_set if digit.length == length
    end
    return nil
  end

  def set_sides
    var1 = get_set_by_length(2)
    var4 = get_set_by_length(4)
    var7 = get_set_by_length(3)
    var8 = get_set_by_length(7)

    a = var7 - var1
    bd = var4 - var1
    cf = var1
    eg = var8 - var7 - var4


    puts a, bd, cf, eg
  end

end

lines = data.map { |line| Line.new(line) }



lines[0].set_sides()
# lines[0].dump()


# C   4
# F   4
# B   2
# D   2
# A   2
# E   1
# G   1
