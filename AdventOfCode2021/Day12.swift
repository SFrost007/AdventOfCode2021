import Foundation

final class Day12: Day {
    
    // MARK: - Initialisation
    
    let nodeLookup: [String: Node]
    
    init(input: String) {
        nodeLookup = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .reduce(into: [:]) { (dict, line) in
                let nodes = line.components(separatedBy: "-").map { dict[$0] ?? Node(name: $0) }
                nodes.first!.addConnection(to: nodes.last!)
                nodes.forEach { dict[$0.name] = $0 }
            }
    }
    
    // MARK: - Data Structure
    
    class Node: Equatable {
        let name: String
        var connections: [Node] = []
        
        init(name: String) {
            self.name = name
        }
        
        func addConnection(to node: Node) {
            guard !connections.contains(node) else { return }
            // Establish two-way link
            connections.append(node)
            node.connections.append(self)
        }
        
        static func == (lhs: Day12.Node, rhs: Day12.Node) -> Bool {
            return lhs.name == rhs.name
        }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        Self.pathCount(nodes: nodeLookup, allowDoubleVisit: false)
    }
    
    func part2() -> Int {
        Self.pathCount(nodes: nodeLookup, allowDoubleVisit: true)
    }
    
    // MARK: - Worker functions
    
    static func pathCount(nodes: [String: Node], allowDoubleVisit: Bool) -> Int {
        Self.pathsFromVisiting(node: nodes["start"]!, in: nodes, visited: [], doubleVisited: !allowDoubleVisit)
            .filter { $0.last == "end" }
            .count
    }
    
    static func pathsFromVisiting(node: Node, in lookup: [String: Node], visited: [String], doubleVisited: Bool) -> [[String]] {
        guard canVisitNode(name: node.name, visited: visited, doubleVisited: doubleVisited) else { return [visited] }
        guard node.name != "end" else { return [visited + ["end"]] }
        let newDoubleVisited = doubleVisited || (node.name.isLowercased() && visited.contains(node.name))
        return node.connections.flatMap {
            pathsFromVisiting(node: $0, in: lookup, visited: visited + [node.name], doubleVisited: newDoubleVisited)
        }
    }
    
    static func canVisitNode(name: String, visited: [String], doubleVisited: Bool) -> Bool {
        guard !name.isUppercased() else { return true }
        guard (name != "start" && name != "end") else { return !visited.contains(name) }
        guard doubleVisited else { return true }
        return !visited.contains(name)
    }
}

// MARK: - Helper extensions

fileprivate extension String {
    func isUppercased() -> Bool { return self.uppercased() == self }
    func isLowercased() -> Bool { return self.lowercased() == self }
}
