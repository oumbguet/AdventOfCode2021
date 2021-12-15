file = File.open("input", "r")
data = file.readlines.map(&:chomp).map { |line| line.split("-") }

require 'colorize'

class Node
    attr_accessor :value, :neighbours, :visited, :big

    def initialize(value)
        @value = value
        @neighbours = []
        @visited = false
        @big = value.match(/[A-Z]+/) != nil
    end

    def dump
        puts "Node: '#{value}'\n\tNeighbours: #{neighbours.map do |x| x.value end }\n\tVisited: #{visited}"
    end
end

class Graph
    attr_accessor :nodes

    def initialize(data)
        @nodes = []
        tmp_dict = Hash.new([])

        data.each do |row|
            tmp_dict[row[0]] += [row[1]]
            tmp_dict[row[1]] += [row[0]]
        end
        
        tmp_dict.keys.each do |k|
            new_node = Node.new(k)
            @nodes += [new_node]
        end

        @nodes.each do |node|
            tmp_dict[node.value].each do |value|
                node.neighbours.push(find_node_by_value(value))
            end
        end
    end

    def find_node_by_value(value)
        @nodes.each do |node|
            if node.value == value
                return node
            end
        end
        return nil
    end

    def dump
        @nodes.each do |node|
            puts node.dump
        end
    end

    def find_paths(current)
        if current.value == 'end'
            return 1
        end
        local_count = 0
        current.visited = true

        current.neighbours.each do |n|
            if n.visited && !n.big
                next
            end
            local_count += find_paths(n)
            n.visited = false
        end

        return local_count
    end
end

graph = Graph.new(data)

puts graph.find_paths(graph.find_node_by_value('start'))