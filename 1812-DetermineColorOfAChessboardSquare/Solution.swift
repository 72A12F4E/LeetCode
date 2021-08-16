class Solution {
    func squareIsWhite(_ coordinates: String) -> Bool {
        // String indexing is always fun... not!
        // this converts the characters `a` thru `h`
        // into `0` thru `8` respectively
        let file = coordinates[coordinates.startIndex]
            .unicodeScalars
            .first!
            .value - 97
        
        let rank = coordinates[
            coordinates.index(after: coordinates.startIndex)
        ].wholeNumberValue! - 1
        
        /// This hairy piece of logic below is a way to
        /// reduce an `if` statement into a boolean expression.
        ///
        /// This code...
        ///
        ///     if rank.isMultiple(of: 2) {
        ///         return !file.isMultiple(of: 2)
        ///     } else {
        ///         return file.isMultiple(of: 2)
        ///     }
        ///
        /// ...is equivalent to this code ⬇️
        ///
        return rank.isMultiple(of: 2) == !file.isMultiple(of: 2)
    }
}