class Solution {
    struct Token: Equatable, CustomStringConvertible {
        let char: Character
        let isStar: Bool
        
        func extractMatches(_ string: String) -> [String?] {
            if isStar {
                var matches: [String] = [""]
                var match = ""
                for c in string {
                    if char == c || char == "." {
                        match.append(c)
                        matches.append(match)
                        continue
                    } else {
                        break
                    }
                }
                return matches
            } else if char == ".", let first = string.first {
                return [String(first)]
            } else if let str = string.first, char == str {
                return [String(char)]
            } else {
                return [nil]
            }
        }
        
        var description: String {
            "\(char)\(isStar ? "*" : "")"
        }
    }
    
    func isMatch(_ s: String, _ p: String) -> Bool {
        return isMatch(s, tokenize(p))
    }
    
    func isMatch(_ string: String, _ pattern: [Token]) -> Bool {
        if let token = pattern.first {
            return token.extractMatches(string).contains { match in
                guard let match = match else { return false }
                var stringCopy = string
                var patternCopy = pattern
                stringCopy.removeFirst(match.count)
                patternCopy.removeFirst()
                return isMatch(stringCopy, patternCopy)
            }
        } else {
            return string.isEmpty
        }
    }
    
    func tokenize(_ pattern: String) -> [Token] {
        var tokens: [Token] = []
        var reversed = String(pattern.reversed())
        var lastChar: Character?
        while let char = reversed.popLast() {
            if char == "*" {
                tokens.removeLast()
                tokens.append(Token(char: lastChar!, isStar: true))
            } else {
                tokens.append(Token(char: char, isStar: false))
            }
            lastChar = char
        }
        var filteredTokens: [Token] = []
        // filter repeated * tokens. `a*a*` is the same as `a*`
        var last: Token?
        for token in tokens {
            if let last = last, last.isStar, last == token {
                continue
            }
            last = token
            filteredTokens.append(token)
        }
        
        return filteredTokens
    }
}
