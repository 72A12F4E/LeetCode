import Foundation

//
// NOTE: I've got an off-by-one error in my windowing 
// code, and its tempting to rewrite this without Swift's
// super awesome correct string indexing logic to figure it out.
// 
class Solution {
    // https://stackoverflow.com/a/34969388
    func permute<C: Collection>(items: C) -> [[C.Iterator.Element]] {
        var scratch = Array(items) // This is a scratch space for Heap's algorithm
        var result: [[C.Iterator.Element]] = [] // This will accumulate our result

        // Heap's algorithm
        func heap(_ n: Int) {
            if n == 1 {
                result.append(scratch)
                return
            }

            for i in 0..<n-1 {
                heap(n-1)
                let j = (n%2 == 1) ? 0 : i
                scratch.swapAt(j, n-1)
            }
            heap(n-1)
        }

        // Let's get started
        heap(scratch.count)

        // And return the result we built up
        return result
    }

    
    
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        // Generate all permuatations of the `words` array.
        // Use indicies instead of passing around strings.
        let permutations = permute(items: Array(0..<words.count))
        
        // loop over permutations, and identify matches.
        // Since all words/permutations are same length, we can optimize
        // with our stepsize
        var matches: [Int] = []
        for permutation in permutations {
            // Transform the permutation into a string for matching
            let permutation = permutation.map { words[$0] }.reduce("", +)
            
            // grab the length of the permutation string
            let permutationLength = permutation.count
            
            var charIndex = s.startIndex
            while let index = s.index(charIndex, offsetBy: permutationLength, limitedBy: s.endIndex), index < s.endIndex {
                // slice out the window
                let window = s[charIndex...]

                // compare window to permutation
                if window.hasPrefix(permutation) {
                    // If we found a match, grab the index & keep it
                    matches.append(s.distance(from: s.startIndex, to: charIndex))
                }
                // advance the window by the step size
                charIndex = s.index(charIndex, offsetBy: 1)
            }
        }
        
        return matches
    }
}

