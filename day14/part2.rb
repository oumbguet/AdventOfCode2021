file = File.open("input", "r")
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
            tmp[k[0] + @rules[k[0] + k[1]]] += v
            tmp[@rules[k[0] + k[1]] + k[1]] += v
        end
        @polymer = tmp
    end

    def count_elems
        elems = Hash.new(0)

        @polymer.each do |k, v|
            elems[k[0]] += v
            elems[k[1]] += v
        end
        higher = elems.map { |k, v| [k, (v.to_f / 2).ceil] }.to_h.sort_by { |k, v| v }.reverse[0][1]
        lower = elems.map { |k, v| [k, (v.to_f / 2).ceil] }.to_h.sort_by { |k, v| v }[0][1]
        higher - lower
    end
end

polymer = Polymer.new(data)

0.upto(39) do |i|
    polymer.replicate
end

puts polymer.count_elems

