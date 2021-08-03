class Solution {
    func validate(_ group: [Character]) -> Bool {
        let group = group.sorted()
        var prev = group.first!
        for char in group.dropFirst() {
            if char != "." && prev == char {
                return false
            }
            prev = char
        }
        return true
    }
    
    // The easiest of the three. Just ensure every row is valid.
    func validateRows(_ board: [[Character]]) -> Bool {
        board.allSatisfy(validate(_:))
    }
    
    // Use a clever indexing trick to "rotate" the board,
    // and then validate it the same way you'd validate rows
    func validateColumns(_ board: [[Character]]) -> Bool {
        (0..<board.count)
            .map { index in
                board.map { $0[index] }
            }
            .allSatisfy(validate(_:))
    }
    
    // Use some more clever indexing tricks to split
    // the board into its 9 square groups. Validate all
    // of these groups.
    func validateSquares(_ board: [[Character]]) -> Bool {
        var groups: [[Character]] = Array(
            repeating: [],
            count: board.count
        )
        for rIndex in 0..<board.count {
            for cIndex in 0..<board.count {
                // Don't be fooled by the "extra" division & multiplication
                // operations. This is integer division, so its a way to
                // keep a calculation within a certian range.
                let square = (rIndex / 3) * 3 + (cIndex / 3)
                groups[square].append(board[rIndex][cIndex])
            }
        }
        return groups.allSatisfy { validate($0) }
    }
    
    /// A sudoku is valid if its rows, columns, and squares
    /// don't have duplicate entries.
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        validateRows(board) &&
            validateColumns(board) &&
            validateSquares(board)
    }
}

// TEST CASES

let solution = Solution()
solution.isValidSudoku(
    [["8","3",".",".","7",".",".",".","."]
    ,["6",".",".","1","9","5",".",".","."]
    ,[".","9","8",".",".",".",".","6","."]
    ,["8",".",".",".","6",".",".",".","3"]
    ,["4",".",".","8",".","3",".",".","1"]
    ,["7",".",".",".","2",".",".",".","6"]
    ,[".","6",".",".",".",".","2","8","."]
    ,[".",".",".","4","1","9",".",".","5"]
    ,[".",".",".",".","8",".",".","7","9"]]
) // false

solution.isValidSudoku(
    [["5","3",".",".","7",".",".",".","."]
    ,["6",".",".","1","9","5",".",".","."]
    ,[".","9","8",".",".",".",".","6","."]
    ,["8",".",".",".","6",".",".",".","3"]
    ,["4",".",".","8",".","3",".",".","1"]
    ,["7",".",".",".","2",".",".",".","6"]
    ,[".","6",".",".",".",".","2","8","."]
    ,[".",".",".","4","1","9",".",".","5"]
    ,[".",".",".",".","8",".",".","7","9"]]
) // true