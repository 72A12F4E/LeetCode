import Foundation
///
/// You have n coins and you want to build a staircase with these
/// coins. The staircase consists of k rows where the ith row has
/// exactly i coins. The last row of the staircase may be incomplete.
///
/// Given the integer n, return the number of complete rows of the
/// staircase you will build.
///
/// Constraints:
///     1 <= n <= 2^31 - 1
///
class Solution {
    // brute force O(n)
    // Just count down the rows lol
    func arrangeCoinsBruteForce(_ n: Int) -> Int {
        var remainingCoins = n
        var rows = 0
        while remainingCoins - rows > 0 {
            rows += 1
            remainingCoins -= rows
        }
        return rows
    }
    
    /// The insight here is that the coin arrangement problem
    /// is similar to the sum of the series of natural numbers.
    ///
    /// https://en.wikipedia.org/wiki/1_%2B_2_%2B_3_%2B_4_%2B_%E2%8B%AF
    ///
    /// The formula for calculating this sum is `(x * (x + 1)) / 2`. We can use the given
    /// value of the number of coins `n` to solve the equation `n = (x * (x + 1)) / 2)`.
    /// Rearranging this equation to solve for `x` (https://www.wolframalpha.com/input?i=n+%3D+%28x+*+%28x+%2B+1%29%29+%2F+2%29+solve+for+x)
    /// provides the formula `0.5 * (sqrt(8 * n + 1) - 1)`.
    ///
    /// Given the problem constraints of `n` being a 32 bit integer, Double's maximum value
    /// at `~1.79 * 10^308`, and our loss of precison with the `sqrt` & `floor`,
    /// we shouldn't overflow with this solution.
    ///
    func arrangeCoinsFancyMathAnswer(_ n: Int) -> Int {
        Int(0.5 * (sqrt(8 * Double(n) + 1) - 1))
    }
}

Solution().arrangeCoinsFancyMathAnswer(Int.max)

