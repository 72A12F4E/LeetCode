class Solution {
    // Conceptually, this one was harder for me beacuse I kept wanting to use
    // Swift's `hasPrefix`. I had to re-read the problem a couple of times
    // after failing the test cases to realize that you can't be a prefix if
    // you only match some of a word. Tricky Tricky.
    // Once I got that detail, it was a piece of cake.
    func isPrefixString(_ s: String, _ words: [String]) -> Bool {
        var str = ""
        for word in words {
            str += word
            if s == str {
                return true
            }
            
            if s.count < str.count {
                return false
            }
        }
        return false
    }
}