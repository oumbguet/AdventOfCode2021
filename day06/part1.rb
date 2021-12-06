file = File.open("input", "r")
data = file.read

fishes = Hash.new(0)

for fish in data.split(",").map(&:to_i)
    fishes[fish] += 1
end

days = 80

1.upto(days) do |i|
    new_fishes = Hash.new(0)

    for fish, count in fishes
        if (fish - 1) < 0
            new_fishes[6] += count
            new_fishes[8] += count
        else
            new_fishes[fish - 1] += count
        end
    end

    fishes = new_fishes
end

puts fishes.values.reduce(:+)