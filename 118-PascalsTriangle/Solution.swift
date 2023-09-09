class Solution {
    func generate(_ numRows: Int) -> [[Int]] {
        var rows: [[Int]] = [[1]]
        for rowIndex in 1..<numRows {
            var row = Array(
                repeating: 1,
                count: rowIndex + 1
            )
            for index in 1..<rowIndex {
                row[index] = rows[rowIndex - 1][index - 1] + rows[rowIndex - 1][index]
            }
            rows.append(row)
        }
        return rows
    }
}