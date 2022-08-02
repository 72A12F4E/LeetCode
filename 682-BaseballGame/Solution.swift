/// You are keeping score for a baseball game with strange rules. The game
/// consists of several rounds, where the scores of past rounds may affect
/// future rounds' scores.
///
/// At the beginning of the game, you start with an empty record. You are given
/// a list of strings ops, where ops[i] is the ith operation you must apply to
/// the record and is one of the following:
///
///     An integer x - Record a new score of x.
///     "+" - Record a new score that is the sum of the previous two scores. It is guaranteed there will always be two previous scores.
///     "D" - Record a new score that is double the previous score. It is guaranteed there will always be a previous score.
///     "C" - Invalidate the previous score, removing it from the record. It is guaranteed there will always be a previous score.
///
/// Return the sum of all the scores on the record.

class Solution {
    func calPoints(_ ops: [String]) -> Int {
        var stack: [Int] = []
        for op in ops {
            switch op {
            case "C":
                stack.popLast()
            case "D":
                stack.append(stack.last! * 2)
            case "+":
                let len = stack.count
                stack.append(stack[len - 1] + stack[len - 2])
            default:
                stack.append(Int(op)!)
            }
        }
        
        return stack.reduce(0, +)
    }
}

let solution = Solution()
solution.calPoints(["5","2","C","D","+"])
