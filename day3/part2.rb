file = File.open("input", "r")
data = file.readlines.map(&:chomp)

def getChar(data, i, co2=false)
    # check first char of each line and count number of 1s and 0s
    ones = 0
    zeros = 0
    data.each do |line|
    if line[i] == "1"
        ones += 1
    else
        zeros += 1
    end
    end

    # display 1 if ones > zeros else 0
    if ones > zeros || ones == zeros
        return co2 ? 0 : 1
    else
        return co2 ? 1 : 0
    end
end


a, b = 0, 0
tmp = data
# filter array to only contain
0.upto(tmp[0].length - 1) do |i|
    n = getChar(tmp, i)

    tmp = tmp.select do |line|
        line[i] == n.to_s
    end

    if tmp.length == 1
        a = tmp[0].to_i(2)
        break
    end
end

tmp = data
# filter array to only contain
0.upto(tmp[0].length - 1) do |i|
    n = getChar(tmp, i, true)

    tmp = tmp.select do |line|
        line[i] == n.to_s
    end

    if tmp.length == 1
        b = tmp[0].to_i(2)
        break
    end
end

puts a, b, a * b