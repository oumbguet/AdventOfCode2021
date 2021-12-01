file = File.open("input")

file_data = file.readlines.map(&:chomp).map(&:to_i)

arr = []

0.upto(file_data.length - 2) do |i|
  arr.push file_data[i..(i + 2)].reduce(:+)
end

count = 0

puts arr[0]
1.upto(arr.length - 2) do |i|
  count += (arr[i] > arr[i - 1] ? 1 : 0)
end

puts count