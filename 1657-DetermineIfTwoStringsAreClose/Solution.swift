class Solution {
    func wc(_ word: String) -> [Character: Int] {
        var map: [Character: Int] = [:]
        for char in word {
            if let count = map[char] {
                map[char] = count + 1
            } else {
                map[char] = 1
            }
        }
        return map
    }
    
    // This one was more of a mental algorithm-y challenge than it was
    // a programming challenge. Given the constraints of the problem, determining
    // what actually was allowed with swapping characters means you had to reduce 
    // the problem to an actual mental challenge rather than doing a variation  
    // of Edit Distance or some other really complicated DP algorithm.
    func closeStrings(_ word1: String, _ word2: String) -> Bool {
        guard word1.count == word2.count else { return false }
        let map1 = wc(word1)
        let map2 = wc(word2)
        return map1.keys.sorted() == map2.keys.sorted() &&
            map1.values.sorted() == map2.values.sorted()
    }
}