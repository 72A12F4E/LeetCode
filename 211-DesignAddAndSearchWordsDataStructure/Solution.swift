import Foundation

class WordDictionary {
    var char: Character?
    var isTerminal: Bool = false
    var children: [WordDictionary] = []
    
    // MARK: API Required by problem
    
    init() { }
    
    func search(_ word: String) -> Bool {
        search(word[...])
    }
    
    func addWord(_ word: String) {
        addWord(word[...])
    }
    
    // MARK: Better API
    
    init(
        char: Character,
        isTerminal: Bool = false,
        children: [WordDictionary] = []
    ) {
        self.char = char
        self.isTerminal = isTerminal
        self.children = children
    }
    
    private func addWord(_ word: Substring) {
        guard let first = word.first else { return }
        let remaining = word.dropFirst()
        if let node = children.first(where: { $0.char == first }) {
            if remaining.isEmpty {
                node.isTerminal = true
            } else {
                node.addWord(remaining)
            }
        } else {
            let node = WordDictionary(char: first)
            if remaining.isEmpty {
                node.isTerminal = true
            } else {
                node.addWord(remaining)
            }
            children.append(node)
        }
    }
    
    private func search(_ word: Substring) -> Bool {
        guard let first = word.first else {
            return false
        }

        if let char = char {
            if first == "." || char == first {
                let remaining = word.dropFirst()
                if remaining.isEmpty {
                    return isTerminal
                }
                return children.contains { $0.search(remaining) }
            } else {
                return false
            }
        } else {
            return children.contains { $0.search(word) }
        }
    }
}

// Your WordDictionary object will be instantiated and called as such
let obj = WordDictionary()
obj.addWord("bad")
obj.addWord("dad")
obj.addWord("mad")
print(obj.search("pad")) // return False
print(obj.search("bad")) // return True
print(obj.search(".ad")) // return True
print(obj.search("b..")) // return True

