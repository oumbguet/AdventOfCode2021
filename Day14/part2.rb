file = File.open("test_input", "r")
data = file.readlines.map(&:chomp)

require 'colorize'

class Polymer
    attr_accessor :polymer, :rules

    def initialize(data)
        @polymer = Hash.new(0)
        0.upto(data[0].length - 2) do |i|
            @polymer[data[0][i] + data[0][i + 1]] += 1
        end

        @rules = {}
        data[2..-1].each do |rule|
            splitted = rule.split(' -> ')
            @rules[splitted[0]] = splitted[1]
        end
    end

    def dump
        puts @polymer
    end

    def replicate
        tmp = Hash.new(0)

        @polymer.each do |k, v|
            tmp[k[0] + @rules[k[0] + k[1]]] += 1
            tmp[@rules[k[0] + k[1]] + k[1]] += 1
        end
        @polymer = tmp
    end

    def count_elems
        count = 0
        elems = Hash.new(0)

        @polymer.each do |k, v|
            count += 2 * v
            elems[k[0]] += v
            elems[k[1]] += v
        end
        puts (count / 2).ceil
        elems.map { |k, v| [k, (v.to_f / 2).ceil] }.to_h
    end
end

polymer = Polymer.new(data)

0.upto(2) do |i|
    polymer.replicate
    puts "step #{i + 1}".green
    polymer.dump
end

puts polymer.count_elems

