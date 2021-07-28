class Solution {
    let mapping: [Character?: Character] = [
        "(": ")",
        "{": "}",
        "[": "]",
    ]
    
    /// LC Easy is Easy. Use a stack to track open parentheses 
    /// then pop from the stack to validate the close matches up.
    /// Good ol CS-101
    func isValid(_ s: String) -> Bool {
        var stack: [Character] = []
        for char in s {
            if char == "(" || char == "{" || char == "[" {
                stack.append(char)
            } else if char != mapping[stack.popLast()] {
                return false
            }
        }
        return stack.isEmpty
    }
}