// Represents a single point on the board.
struct Point: Equatable, Hashable {
    let x: Int
    let y: Int
    
    func adjacentPoints(_ bounds: Point) -> [Point] {
        var points: [Point] = []
        if 0 < x {
            points.append(Point(x: x - 1, y: y))
        }
        if 0 < y {
            points.append(Point(x: x, y: y - 1))
        }
        if x < bounds.x - 1 {
            points.append(Point(x: x + 1, y: y))
        }
        if y < bounds.y - 1 {
            points.append(Point(x: x, y: y + 1))
        }
        return points
    }
}

// Helper method to compute the size of the board
func bounds(_ board: [[Character]]) -> Point {
    return .init(x: board.count, y: board[0].count)
}

class Solution {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let bounds = bounds(board)
        for (i, chars) in board.enumerated() {
            for (j, char) in chars.enumerated() where char == word.first {
                let point = Point(x: i, y: j)
                if exist(
                    board,
                    bounds: bounds,
                    remainingWord: String(word.dropFirst()),
                    head: point,
                    visited: [point]
                ) {
                    return true
                }
            }
        }
        
        return false
    }
    
    // Recursive DFS for finding words.
    func exist(
        _ board: [[Character]],
        bounds: Point,
        remainingWord: String,
        head: Point,
        visited: [Point]
    ) -> Bool {
        // If the remaining word is empty, congrats!
        // You've already found the word!
        if remainingWord.isEmpty {
            return true
        }
        // Find the next possible point(s) you haven't visited
        let nextPoints = head
            .adjacentPoints(bounds)
            .filter { !visited.contains($0) }

        // If any of these points match the next letter of the word, recurse!
        for next in nextPoints where board[next.x][next.y] == remainingWord.first {
            if exist(
                board,
                bounds: bounds,
                remainingWord: String(remainingWord.dropFirst()),
                head: next,
                visited: visited + [next]
            ) {
                return true
            }
        }
        
        return false
    }
}

let solution = Solution()
solution.exist([
    ["A","B","C","E"],
    ["S","F","C","S"],
    ["A","D","E","E"]
], "ABCCED")
solution.exist([
    ["A","B","C","E"],
    ["S","F","C","S"],
    ["A","D","E","E"]
], "SEE")
solution.exist([
    ["A","B","C","E"],
    ["S","F","C","S"],
    ["A","D","E","E"]
], "ABCB")
