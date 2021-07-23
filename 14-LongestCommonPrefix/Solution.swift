class Solution {

    // Its a LeetCode easy, so not much to explain here. The naive solution works.
    // 
    // First off, figure out the absolute maximum number of possible iterations by finding 
    // the length of the shortest string.
    // 
    // Next, step over each character in every string, and if theres a mismatch, you're finished.
    //
    // Swift String API makes this look more verbose than necessary, but hey, it'll work for Unicode
    // test inputs including those weird conjoined emoji symbols. 
    //
    // Worst case runtime is O(n * lengthOfShortestString), but I think the `.map(\.count).min()` makes 
    // it O(n^2) maybe. I kind of forget how Strings work.

    func longestCommonPrefix(_ strs: [String]) -> String {
        var prefix = ""
        let iterations = strs.map(\.count).min()!
        for i in 0..<iterations {
            let firstString = strs.first!
            let char = firstString[firstString.index(firstString.startIndex, offsetBy: i)]
            for string in strs.dropFirst() {
                if char != string[string.index(string.startIndex, offsetBy: i)] {
                    return prefix
                }
            }
            
            prefix.append(char)
        }
        
        return prefix
    }
}