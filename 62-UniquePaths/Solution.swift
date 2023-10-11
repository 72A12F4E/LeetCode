
class Solution {
    struct Coordinate: Hashable {
        let m, n: Int
    }
    var paths: [Coordinate: Int] = [:]
    
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        if n == 1 || m == 1 {
            return 1
        }
        if let paths = paths[Coordinate(m: m, n: n)] {
            return paths
        }
        
        let downCoordinate = Coordinate(m: m - 1, n: n)
        var down = paths[downCoordinate]
        if down == nil {
            down = uniquePaths(m - 1, n)
            paths[downCoordinate] = down
        }
        
        let rightCoordinate = Coordinate(m: m, n: n - 1)
        var right = paths[rightCoordinate]
        if right == nil {
            right = uniquePaths(m, n - 1)
            paths[rightCoordinate]
        }
        
        return down! + right!
    }
}
