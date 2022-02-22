class Solution {
    func largestNumber(_ nums: [Int]) -> String {
        let seq = nums.sorted { left, right in
            let l = String(left)
            let r = String(right)
            return Int(l + r)! > Int(r + l)!
        }
        .map(String.init)
        .joined()
        .drop {
            $0 == "0"
        }
        
        /// Fix the dumb edge case where you'd get extra leading zeros on output
        return seq.isEmpty ? "0" : String(seq)
    }
}

