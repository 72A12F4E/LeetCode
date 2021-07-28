class Solution {
    let mapping: [Character: String] = [
        "2": "abc",
        "3": "def",
        "4": "ghi",
        "5": "jkl",
        "6": "mno",
        "7": "pqrs",
        "8": "tuv",
        "9": "wxyz",
    ]
    /// Big O of some big factorial! number. 
    /// the `combinations` array just gets bigger and bigger
    /// the more input you have.
    func letterCombinations(_ digits: String) -> [String] {
        guard !digits.isEmpty else { return [] }
        var combinations: [String] = []
        for char in mapping[digits.first!]! {
            combinations.append(String(char))
        }
        for digit in digits.dropFirst() {
            var combos: [String] = []
            let letters = mapping[digit]!
            for letter in letters {
                for combo in combinations {
                    let str = combo + String(letter)
                    combos.append(str)
                }
            }
            combinations = combos
        }
        return combinations
    }
}