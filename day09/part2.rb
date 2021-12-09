file = File.open("input", "r")
data = file.readlines.map(&:chomp).map { |line| line.split('').map(&:to_i) }

require 'colorize'

count = 0

basins = {}

def check_around(data, coord)
    if data[coord[0]][coord[1]] == 9
        return 0;
    end
    local_count = 1
    data[coord[0]][coord[1]] = '.'

    i, j = coord[0], coord[1]

    if (i - 1) >= 0 && data[i - 1][j] != '.'
        local_count += check_around(data, [i - 1, j])
    end
    if (i + 1) < data.length && data[i + 1][j] != '.'
        local_count += check_around(data, [i + 1, j])
    end
    if (j - 1) >= 0 && data[i][j - 1] != '.'
        local_count += check_around(data, [i, j - 1])
    end
    if (j + 1) < data[0].length && data[i][j + 1] != '.'
        local_count += check_around(data, [i, j + 1])
    end
    return local_count
end

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
      count += data[i][j] + 1
      basins[[i,j]] = 0
    end
        # if data[i][j] == 9
        #     print data[i][j].to_s.colorize(:red)
        # else
        #     print data[i][j]
        # end
    end
    #   puts ''
end

results = {}

basins.each do |key, value|
    results[key] = check_around(data, [key[0], key[1]])
end

puts results.values.sort[-3..-1].reduce(:*)