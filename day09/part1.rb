file = File.open("input", "r")
data = file.readlines.map(&:chomp).each { |line| line.split('').map(&:to_i) }

require 'colorize'

count = 0

0.upto(data.length - 1) do |i|
  0.upto(data[i].length - 1) do |j|
    lower = true
    if (i - 1) >= 0 && data[i][j] >= data[i - 1][j]
      lower = false
    end
    if (i + 1) < data.length && data[i][j] >= data[i + 1][j]
      lower = false
    end
    if (j - 1) >= 0 && data[i][j] >= data[i][j - 1]
      lower = false
    end
    if (j + 1) < data[0].length && data[i][j] >= data[i][j + 1]
      lower = false
    end
    if lower
      count += data[i][j].to_i + 1
      print data[i][j].colorize(:blue)
    else
      if data[i][j].to_i == 9
        print data[i][j].colorize(:red)
      else
        print data[i][j]
      end
    end
  end
  puts ''
end

puts count