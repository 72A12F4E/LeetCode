import Foundation

class Solution {
    func parseDigit(_ input: String) -> (Int, String) {
        let number = String(input.prefix { $0.isNumber })
        let remaining = String(input.drop { $0.isNumber })
        return (Int(number)!, remaining)
    }
    
    func parse(_ input: String, result: String) -> String {
        // Our recursive base case is when the input is empty.
        // In that case, the `result` contains the answer!
        guard let char = input.first else {
            return result
        }
        
        if char.isLetter {
            // If we've found a letter, just append it
            // to the result and parse the remaining input
            return parse(
                String(input.dropFirst()),
                result: result + String(char)
            )
        } else if char.isNumber {
            
            let (number, remaining) = parseDigit(input)
            
            // This cool little trick lets us count how many digits
            // were just parsed, so we can slice up the input. I know
            // I could just handle this in `parseDigit`, but this was
            // more fun in the moment.
            let numberLength = Int(log(Double(number)) / log(10.0)) + 1
            
            // find matching brackets with a """stack""" 😉.
            var stack = 0
            var index = number
            for (offset, char) in remaining.enumerated() {
                if char == "[" {
                    stack += 1
                } else if char == "]" {
                    stack -= 1
                }
                
                if stack == 0 {
                    index = offset
                    break
                }
            }
        
            // Slice out the bracketed string and parse it
            let start = input.index(
                input.startIndex,
                offsetBy: numberLength + 1
            )
            let end = input.index(
                input.startIndex,
                offsetBy: numberLength + index
            )
            let bracketedRange = String(input[start..<end])
            let parsed = parse(bracketedRange, result: "")
            
            // Grab the rest of the input that hasn't been parsed.
            // Don't forget about bounds checking. 😉
            let rest = end < input.endIndex ?
                String(input[input.index(after: end)...]) :
                ""
            
            // Update the result with the parsed range
            // and parse the rest of the input.
            return parse(
                rest,
                result: result + String(repeating: parsed, count: number)
            )
        }
            
        // Since the LeetCode input is well-formed, its safe
        // to `fatalError` here. In the "real world", this
        // would be a good spot for error handling.
        fatalError("this shouldn't happen")
    }

    func decodeString(_ s: String) -> String {
        parse(s, result: "")
    }
}
