/// Write an algorithm to determine if a number n is happy.
///
/// A happy number is a number defined by the following process:
///
/// * Starting with any positive integer, replace the number by the sum of the squares of its digits.
/// * Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
/// * Those numbers for which this process ends in 1 are happy.
///
/// Return true if n is a happy number, and false if not.
///

class Solution {
    func isHappy(_ n: Int) -> Bool {
        var number = n
        var results: Set<Int> = []
        while true {
            let result = String(number)
                .compactMap(\.wholeNumberValue)
                .map { $0 * $0 }
                .reduce(0, +)
            
            if result == 1 {
                return true
            } else if results.contains(result) {
                return false
            } else {
                results.insert(result)
                number = result
            }
        }
    }
}


let solution = Solution()
solution.isHappy(2)
