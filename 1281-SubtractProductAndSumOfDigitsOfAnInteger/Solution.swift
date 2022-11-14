class Solution {
    func subtractProductAndSum(_ n: Int) -> Int {
        let digits = String(n).compactMap(\.wholeNumberValue)
        return digits.reduce(1, *) - digits.reduce(0, +)
    }
}