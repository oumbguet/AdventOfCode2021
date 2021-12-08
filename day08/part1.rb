file = File.open("input", "r")
data = file.readlines.map(&:chomp)

class Line
  attr_accessor :digits, :outputs

  def initialize(line)
    splitted = line.split(" |")

    @digits = splitted[0].split(" ")
    @outputs = splitted[1].split(" ")
  end

  def dump
    puts "digits: #{@digits}"
    puts "outputs: #{@outputs}"
  end
end

lines = data.map { |line| Line.new(line) }

count = 0
lines.each do |line|
    line.outputs.each do |output|
        if output.length == 2 || output.length == 3 || output.length == 4 || output.length == 7
            count += 1
        end
    end
end

puts count