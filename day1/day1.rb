file = File.open("input")

data = file.readlines.map(&:chomp).map(&:to_i)

count = 0

1.upto(arr.length - 2) do |i|
  count += (data[i..(i + 2)].reduce(:+) > data[(i - 1)..(i + 1)].reduce(:+) ? 1 : 0)
end

puts count