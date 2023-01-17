
//Given a positive integer n, you can apply one of the following operations:
//
//If n is even, replace n with n / 2.
//If n is odd, replace n with either n + 1 or n - 1.
//Return the minimum number of operations needed for n to become 1.

// This one is kind of a dumb gotcha style question,
// but the key thing is that we want to hit a situation
// where we'll consistently be dividing by 2 each time and
// should target numbers that lead to streaks of even numbers.

class Solution {
    func integerReplacement(_ n: Int) -> Int {
        var count = 0
        var value = n
        while value != 1 {
            if value.isMultiple(of: 2) {
                value /= 2
            } else if value == 3 || (value / 2).isMultiple(of: 2) {
                value -= 1
            } else {
                value += 1
            }
            count += 1
        }
        return count
    }
}

let solution = Solution()
solution.integerReplacement(65535)