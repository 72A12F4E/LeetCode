class Solution {
    
    // This problem is kind of difficult if you didn't already
    // know the algorithm to begin with, but with a little fancy
    // bitwise math you can compute an answer with a moderate
    // amount of work.
    
    func hammingWeight(_ n: Int) -> Int {
        // variable to hold total count of the number of ones
        var count = 0
        // make a mutable copy of `n`, so we can manipulate bits
        var n = n
        // while n is greater than zero...
        while n > 0 {
            /// bitwise AND n with itself minus 1, and re-assign it
            /// to `n`. To understand how & why this works, lets look
            /// at a simple example.
            ///
            /// Suppose `n` is `13`
            /// If we bitwise AND `13` & `12` (`0b1101` & `0b1100`),
            /// we'll get `12`. (`0b1100`)
            /// Increment the counter.
            ///
            /// `n` is now `12`
            /// If we bitwise AND `12` with `11` (`0b1100` & `0b1011`),
            /// we'll get `8`. (`0b1000`)
            /// Increment the counter.
            ///
            /// `n` is now `8`
            /// If we bitwise AND `8` and `7` (`0b1000` & `0b0111`),
            /// we'll get `0`. (`0b0000`)
            /// Increment the counter.
            ///
            /// Now that `n` is zero, we break the loop.
            n = n & (n - 1)
            count += 1
        }
        
        // Return the total count of all the 1's
        return count
        
        // On an interesting note, if you wanted to find the count of
        // zeros, just subtract this answer from the number of bits in
        // whatever integer representation your system is using.
    }
}
