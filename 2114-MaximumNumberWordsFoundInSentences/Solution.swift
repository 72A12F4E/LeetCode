class Solution {
    func mostWordsFound(_ sentences: [String]) -> Int {
        // For a more space-efficient solution, add `.lazy` after `sentences`
        sentences.map {
            $0.filter(\.isWhitespace).count
        }.max() + 1 ?? 0
    }
}
