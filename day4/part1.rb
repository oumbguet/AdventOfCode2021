file = File.open("input", "r")
data = file.readlines.map(&:chomp)

numbers, data = data[0].split(",").map(&:to_i), data[2..-1]

bingos = []
while data && data.length > 0
    bingos.push(data[0..4])
    data = data[6..-1]
end

def get_unmarked_numbers(bingo)
    return bingo.join(' ').gsub('X', '0').split(' ').map(&:to_i).reduce(:+)
end

def check_col(bingo)
    (0..4).each do |i|
        col = true
        bingo.each do |row|
            if row[i] != "X"
                col = false
            end
        end
        if col
            return true
        end
    end

    return false
end

def check_row(bingo)
    bingo.each do |row|
        if row == 'X X X X X'
            return true
        end
    end
    return false
end

def check_bingo(bingo)
    return check_col(bingo) || check_row(bingo)
end

def check_number(bingo, number)
    result = []

    bingo.each do |row|
        splitted_line = row.split(" ")
        result.push(splitted_line.map { |x| x == number.to_s ? 'X' : x }.join(" "))
    end
    return result
end

puts "We're looking for the first board to win"

numbers.each do |n|
    bingos.each_with_index do |bingo, index|
        bingos[index] = check_number(bingo, n)
        if check_bingo(bingos[index])
            puts "Winning number: #{n}\nUnmarked number sum: #{get_unmarked_numbers(bingos[index])}\nProduct of these two: #{n * get_unmarked_numbers(bingos[index])}"
            exit
        end
    end
    bingos[0] = check_number(bingos[0], n)
    if check_bingo(bingos[0])
        break
    end
end