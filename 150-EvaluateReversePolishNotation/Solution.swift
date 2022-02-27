/// Evaluate the value of an arithmetic expression in Reverse Polish Notation.
///
/// Valid operators are +, -, *, and /. Each operand may be an integer or
/// another expression.
///
/// Note that division between two integers should truncate toward zero.
///
/// It is guaranteed that the given RPN expression is always valid. That means
/// the expression would always evaluate to a result, and there will not be any
/// division by zero operation.

class Solution {
    let operatorMapping: [String: (Int, Int) -> Int] = [
        "+": { l, r in l + r },
        "-": { l, r in l - r },
        "*": { l, r in l * r },
        "/": { l, r in l / r },
    ]
    
    func evalRPN(_ tokens: [String]) -> Int {
        var stack: [Int] = []
        for token in tokens {
            if let number = Int(token) {
                stack.append(number)
            } else if let operation = operatorMapping[token] {
                let right = stack.popLast()!
                let left = stack.popLast()!
                stack.append(operation(left, right))
            } else {
                fatalError("Invalid Input")
            }
        }
        return stack.popLast()!
    }
}

let solution = Solution()
solution.evalRPN(["10","6","9","3","+","-11","*","/","*","17","+","5","+"])
solution.evalRPN(["4","3","-"])