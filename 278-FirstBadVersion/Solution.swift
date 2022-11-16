// Not much to see here, just a normal binary search.

class Solution: VersionControl {
    func firstBadVersion(_ n: Int) -> Int {
        var low = 1
        var high = n
        while low < high {
            var test = (high + low) / 2
            if isBadVersion(test) {
                high = test
            } else {
                low = test + 1
            }
        }
        
        return low
    }
}