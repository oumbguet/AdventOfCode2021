file = File.open("input", "r")
data = file.readlines.map(&:chomp)

class Line
  attr_accessor :digits, :outputs, :set1, :set4, :set7, :set8, :setTable

  def initialize(line)
    splitted = line.split(" |")

    @digits = splitted[0].split(" ")
    @outputs = splitted[1].split(" ")
    @setTable = {}
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

  def def_sets
    @set1 = get_set_by_length(2)
    @set4 = get_set_by_length(4)
    @set7 = get_set_by_length(3)
    @set8 = get_set_by_length(7)
  end

  def resolve_sides
    @digits.each do |digit|
        if digit.length == 2
            setTable[digit.split('').to_set] = 1
        elsif digit.length == 4
            setTable[digit.split('').to_set] = 4
        elsif digit.length == 3
            setTable[digit.split('').to_set] = 7
        elsif digit.length == 7
            setTable[digit.split('').to_set] = 8
        elsif digit.length == 5
            if (@set1 & digit.split('').to_set).size == 2
                setTable[digit.split('').to_set] = 3
            elsif (@set4 & digit.split('').to_set).size == 2
                setTable[digit.split('').to_set] = 2
            else
                setTable[digit.split('').to_set] = 5
            end
        elsif digit.length == 6
            if (@set1 & digit.split('').to_set).size == 1
                setTable[digit.split('').to_set] = 6
            elsif (@set4 & digit.split('').to_set).size == 4
                setTable[digit.split('').to_set] = 9
            else
                setTable[digit.split('').to_set] = 0
            end
        end
    end
  end

  def get_solutions
    @solutions = []
    @outputs.each do |output|
        @solutions << setTable[output.split('').to_set]
    end
    @solutions
  end

end

lines = data.map { |line| Line.new(line) }

count = 0
lines.each do |line|
    line.def_sets
    line.resolve_sides
    count += line.get_solutions.join('').to_i
end

puts count
