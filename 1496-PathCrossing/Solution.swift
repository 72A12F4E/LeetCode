// problem constraints say max value will never exceed 10,000
struct Point: Hashable {
    var x: Int16
    var y: Int16
}

class Solution {
    func isPathCrossing(_ path: String) -> Bool {
        var current: Point = Point(x: 0, y: 0)
        var visited: Set<Point> = [current]
        for char in path {
            switch char {
            case "N":
                current.y += 1
            case "E":
                current.x += 1
            case "S":
                current.y -= 1
            case "W":
                current.x -= 1
            default:
                fatalError("invalid direction")
            }
            
            if visited.contains(current) {
                return true
            } else {
                visited.insert(current)
            }
        }
        return false
    }
}

let solution = Solution()
solution.isPathCrossing("NES")
