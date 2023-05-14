class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        toDict(s) == toDict(t)
    }
    
    func toDict(_ input: String) -> [Character: Int] {
        var dict: [Character: Int] = [:]
        for char in input {
            let count = dict[char] ?? 0
            dict[char] = count + 1
        }
        return dict
    }
}
