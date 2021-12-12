import Foundation

class Day12 {
    
    // MARK: - Initialisation
    
    let nodeLookup: [String: Node]
    
    init(inputURL: URL) {
        var nodeCache: [String: Node] = [:]
        try! String(contentsOf: inputURL)
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .forEach {
                let nodes = $0
                    .components(separatedBy: "-")
                    .map { nodeCache[$0] ?? Node(name: $0) }
                nodes.first!.addConnection(to: nodes.last!)
                nodes.forEach { nodeCache[$0.name] = $0 }
            }
        nodeLookup = nodeCache
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
        
        var isUppercase: Bool { name.uppercased() == name }
        
        static func == (lhs: Day12.Node, rhs: Day12.Node) -> Bool {
            return lhs.name == rhs.name
        }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        Self.pathsFromVisiting(node: nodeLookup["start"]!, in: nodeLookup, visited: [])
            .filter { $0.last == "end" }
            .count
    }
    
    func part2() -> Int {
        fatalError("Not yet implemented")
    }
    
    static func pathsFromVisiting(node: Node, in lookup: [String: Node], visited: [String]) -> [[String]] {
        guard node.isUppercase || !visited.contains(node.name) else { return [visited] }
        guard node.name != "end" else { return [visited + ["end"]] }
        return node.connections.flatMap {
            pathsFromVisiting(node: $0, in: lookup, visited: visited + [node.name])
        }
    }
    
}
