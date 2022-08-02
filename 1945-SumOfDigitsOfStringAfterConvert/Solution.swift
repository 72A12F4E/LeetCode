class Solution {
    func getLucky(_ s: String, _ k: Int) -> Int {
        var string = s.compactMap(\.asciiValue)
            .map {
                "\($0 - 96)"
            }.reduce("", +)
        
        for _ in 0..<k {
            string = "\(string.compactMap(\.wholeNumberValue).reduce(0, +))"
        }
        
        return Int(string)!
    }
}


let solution = Solution()
solution.getLucky("zbax", 2)
solution.getLucky("iiii", 1)
