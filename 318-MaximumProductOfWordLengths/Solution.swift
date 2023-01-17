import Foundation

extension String {
    var bitmask: Int {
        var mask = 0
        for char in self {
            mask |= 1 << (char.asciiValue! - Character("a").asciiValue!)
        }
        return mask
    }
}

class Solution {
    // Normally you'd just use a set right?
    // turns out thats pretty inefficient when your problem
    // space is constrained to just lowercase letters...
    func maxProductBrute(_ words: [String]) -> Int {
        let words = words
            .sorted {
                $0.count > $1.count
            }
        
        var product = 0
        for i in 0..<words.count {
            for j in 0..<words.count where i != j {
                if Set(words[i]).isDisjoint(with: Set(words[j])) {
                    product = max(product, words[i].count * words[j].count)
                }
            }
        }
        return product
    }
    
    // Instead of a Set, use an integer bitmask to represent the Set.
    //
    // Ex. "a" = 0b0001, "acd" => 0b1101, etc...
    //
    // Use a Bitwise AND to check for disjoint sets, and iterate over
    // the results in a triangular pattern to avoid unnecessary comparisons
    func maxProduct(_ words: [String]) -> Int {
        let masks = words.map(\.bitmask)
        
        var product = 0
        for i in 0..<masks.count {
            for j in (i + 1)..<masks.count where i != j {
                if masks[i] & masks[j] == 0 {
                    product = max(product, words[i].count * words[j].count)
                }
            }
        }
        return product
    }
}

let solution = Solution()
solution.maxProduct(["abcw","baz","foo","bar","xtfn","abcdef"]) // 16
solution.maxProduct(["a","ab","abc","d","cd","bcd","abcd"]) // 4
solution.maxProduct(["a","aa","aaa","aaaa"]) // 0
solution.maxProduct(["eae","ea","aaf","bda","fcf","dc","ac","ce","cefde","dabae"]) // 15
