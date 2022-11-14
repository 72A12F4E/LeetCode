class Solution {
    func convert(_ s: String, _ numRows: Int) -> String {
        guard numRows > 1 else { return s }
        /// Yeah, there is some unnecessary memory here but it works...
        var rows = Array(Array(repeating: "", count: numRows))
        var rowIndex = 0
        var isDown = true
        for char in s {
            rows[rowIndex].append(char)
            
            if isDown {
                rowIndex += 1
            } else {
                rowIndex -= 1
            }
            
            if rowIndex == 0 || rowIndex == numRows - 1 {
                isDown.toggle()
            }
        }
        
        return rows.reduce("", +)
    }
}
