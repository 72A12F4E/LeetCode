// This somehow passes...
// * 290ms beats 14.52%
// * 15.8 MB beats 97.26%
class CheatyTrie {
    var set: Set<String> = []

    init() {}

    func insert(_ word: String) {
        set.insert(word)
    }

    func search(_ word: String) -> Bool {
        set.contains(word)
    }

    func startsWith(_ prefix: String) -> Bool {
        set.contains { key in
            key.hasPrefix(prefix)
        }
    }
}

// This was fun, and I'm sure I could optimize
// more, but I think I'm satisfied for now.

class Trie {
    struct Node: Hashable {
        let value: Character
        var isTerminal: Bool
        var children: [Character: Node] = [:]
        
        init(value: Character, isTerminal: Bool) {
            self.value = value
            self.isTerminal = isTerminal
        }
        
        mutating func insert(word: Substring) {
            guard let char = word.first else { return }
            let letters = word.dropFirst()
            if children[char] != nil {
                children[char]!.insert(word: letters)
                children[char]!.isTerminal = children[char]!.isTerminal || letters.isEmpty
            } else {
                var new = Node(value: char, isTerminal: letters.isEmpty)
                new.insert(word: letters)
                children[char] = new
            }
        }
        
        func contains(_ word: Substring) -> Bool {
            guard !word.isEmpty else { return isTerminal }
            let letters = word.dropFirst()
            guard let nextLetter = letters.first else {
                return isTerminal
            }
            guard let next = children[nextLetter] else {
                return false
            }
            return next.contains(letters)
        }
        
        func hasPrefix(_ prefix: Substring) -> Bool {
            guard !prefix.isEmpty else { return true }
            let letters = prefix.dropFirst()
            guard let nextLetter = letters.first else {
                return true
            }
            guard let node = children[nextLetter] else {
                return false
            }
            return node.hasPrefix(letters)
        }
        
        // MARK: Equatable
        
        static func ==(lhs: Node, rhs: Node) -> Bool {
            lhs.value == rhs.value
        }
        
        // MARK: Hashable
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }
    }
    
    // Dict makes initial lookup into O(1), vs O(n) for Array
    var nodes: [Character: Node] = [:]
    
    init() {}
    
    func insert(_ word: String) {
        guard let char = word.first else { return }
        let letters = word.dropFirst()
        if nodes[char] != nil {
            nodes[char]!.insert(word: letters)
        } else {
            var new = Node(value: char, isTerminal: letters.isEmpty)
            new.insert(word: letters)
            nodes[char] = new
        }
    }
    
    func search(_ word: String) -> Bool {
        guard let char = word.first, let node = nodes[char] else { return false }
        return node.contains(word[...])
    }
    
    func startsWith(_ prefix: String) -> Bool {
        guard let char = prefix.first, let node = nodes[char] else { return false }
        return node.hasPrefix(prefix[...])
    }
}

extension Trie: CustomStringConvertible {
    var description: String {
        "\(nodes)"
    }
}

extension Trie.Node: CustomStringConvertible {
    var description: String {
        "(\(value), \(isTerminal)) -> \(children)"
    }
}

var trie = Trie()
trie.insert("app")
trie.insert("apple")
trie.insert("beer")
trie.insert("add")
trie.insert("jam")
trie.insert("rental")
print(trie.search("apps")         == false ? "✅" : "❌")
print(trie.search("app")          == true ? "✅" : "❌")
print(trie.search("ad")           == false ? "✅" : "❌")
print(trie.search("applepie")     == false ? "✅" : "❌")
print(trie.search("rest")         == false ? "✅" : "❌")
print(trie.search("jan")          == false ? "✅" : "❌")
print(trie.search("rent")         == false ? "✅" : "❌")
print(trie.search("beer")         == true ? "✅" : "❌")
print(trie.search("jam")          == true ? "✅" : "❌")
print(trie.startsWith("apps")     == false ? "✅" : "❌")
print(trie.startsWith("app")      == true ? "✅" : "❌")
print(trie.startsWith("ad")       == true ? "✅" : "❌")
print(trie.startsWith("applepie") == false ? "✅" : "❌")
print(trie.startsWith("rest")     == false ? "✅" : "❌")
print(trie.startsWith("jan")      == false ? "✅" : "❌")
print(trie.startsWith("rent")     == true ? "✅" : "❌")
print(trie.startsWith("beer")     == true ? "✅" : "❌")
print(trie.startsWith("jam")      == true ? "✅" : "❌")
                            
