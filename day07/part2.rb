file = File.open("input", "r")
data = file.read

crabs = Hash.new(0)

for crab in data.split(",").map(&:to_i)
    crabs[crab] += 1
end

tmp = 99999999999

0.upto(crabs.keys.max) do |i|
    total_fuel = 0

    crabs.each do |k, v|
        n = (k - i).abs.to_f
        total_fuel += (n * ((n + 1) / 2)) * v
    end
    if total_fuel < tmp
        puts "New min fuel: #{total_fuel}, with #{i}"
        tmp = total_fuel
    end
end
