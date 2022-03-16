import UIKit

/// The DNA sequence is composed of a series of nucleotides
/// abbreviated as 'A', 'C', 'G', and 'T'.
///
///    For example, "ACGAATTCCG" is a DNA sequence.
///
/// When studying DNA, it is useful to identify repeated sequences
/// within the DNA.
///
/// Given a string s that represents a DNA sequence, return all the 10-letter-long
/// sequences (substrings) that occur more than once in a DNA molecule. You may
/// return the answer in any order.

class Solution {
    let sequenceLength = 10
    
    // O(n) sliding window approach with a dictionary
    //
    // Performance note, we use String.SubSequence a lot here
    // because its reference semantic, so we don't have to alloc
    // a bunch of extra Strings until the very end.
    func findRepeatedDnaSequences(_ s: String) -> [String] {
        guard s.count > sequenceLength else { return [] }
        var dict: [String.SubSequence: Int] = [:]
        
        var start = s.startIndex
        var end = s.index(s.startIndex, offsetBy: sequenceLength - 1)
        while end != s.endIndex {
            let seq = s[start...end]
            if let count = dict[seq] {
                dict[seq] = count + 1
            } else {
                dict[seq] = 1
            }
            start = s.index(start, offsetBy: 1)
            end = s.index(end, offsetBy: 1)
        }

        // a lazy sequence here gives marginally better memory performance, since
        // we don't need to alloc an extra array with the filter and map calls. 
        return dict.lazy.filter {
            $0.value > 1
        }.map {
            String($0.key)
        }
    }
    
    // Brute force: O(n^2), just compare all the strings in 
    // nested for loops. A little smart since we start the inner
    // loop at the current index of the outer loop, but still not
    // great performance-wise.
    func findRepeatedDnaSequencesBruteForce(_ s: String) -> [String] {
        guard s.count > sequenceLength else { return [] }
        var set = Set<String.SubSequence>()
        for i in 0...s.count - sequenceLength {
            let sub1 = s[s.index(s.startIndex, offsetBy: i)...s.index(s.startIndex, offsetBy: i + sequenceLength - 1)]
            for j in i...(s.count - sequenceLength) where i != j {
                let sub2 = s[s.index(s.startIndex, offsetBy: j)...s.index(s.startIndex, offsetBy: j + sequenceLength - 1)]
                if sub1 == sub2 {
                    set.insert(sub2)
                }
            }
        }
        return Array(set.map(String.init))
    }
}

let solution = Solution()
solution.findRepeatedDnaSequences("AAAAAAAAAAA") // ["AAAAAAAAAA"]
solution.findRepeatedDnaSequences("AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT") // ["AAAAACCCCC","CCCCCAAAAA"]

