class Solution {
    func removeDuplicatedWords(_ words: [String]) -> Set<String> {
        var pruned: Set<String> = []
        var dupes: Set<String> = []
        for word in words {
            if pruned.contains(word)  {
                pruned.remove(word)
                dupes.insert(word)
            }
            
            if !dupes.contains(word) {
                pruned.insert(word)
            }
        }
        return pruned
    }
    
    func countWords(_ words1: [String], _ words2: [String]) -> Int {
        removeDuplicatedWords(words1)
            .intersection(removeDuplicatedWords(words2))
            .count
    }
}


let solution = Solution()
solution.removeDuplicatedWords(["a","ab"])
solution.removeDuplicatedWords(["a","a","a","ab"])
solution.countWords(["a","ab"], ["a","a","a","ab"])
