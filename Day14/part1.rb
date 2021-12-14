file = File.open("input", "r")
data = file.readlines.map(&:chomp)

require 'colorize'

class Polymer
    attr_accessor :polymer, :rules

    def initialize(data)
        @polymer = data[0].split('')
        @rules = {}
        data[2..-1].each do |rule|
            splitted = rule.split(' -> ')
            @rules[splitted[0]] = splitted[1]
        end
    end

    def dump
        puts @polymer.join
    end

    def replicate
        tmp = []

        0.upto(@polymer.length - 2) do |i|
            tmp << @polymer[i]
            if @rules.has_key?(@polymer[i] + @polymer[i+1])
                tmp << @rules[@polymer[i] + @polymer[i+1]]
            end
        end
        tmp << @polymer[-1]
        @polymer = tmp
    end

    def count_elems
        counts = {}

        @polymer.uniq.each do |elem|
            counts[elem] = @polymer.count(elem)
        end
        lower = counts.sort_by { |k, v| v }[0].last
        higher = counts.sort_by { |k, v| v }[-1].last

        puts higher - lower
    end
end

polymer = Polymer.new(data)

0.upto(9) do |i|
    polymer.replicate
end

polymer.count_elems

