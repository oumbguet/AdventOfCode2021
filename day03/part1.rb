file = File.open("input", "r")
data = file.readlines.map(&:chomp)

def getChar(data, i)
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
    if ones > zeros
        return 1
    else
        return 0
    end
end

result = ''
# puts getCHar for i in 0 line.length
for i in 0...data[0].length
    # puts getChar(data, i)

    # add getchar i to result string
    result += getChar(data, i).to_s

end

# display result converted to binary
epsilon = result.to_i(2)

gamma = result.split('').map { |bit| bit == "1" ? "0" : "1" }.join('').to_i(2)

puts epsilon * gamma