class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var groups: [[Character]: [String]] = [:]
        for (original, sorted) in strs.map({($0, $0.sorted())}) {
            if groups[sorted] != nil {
                groups[sorted]?.append(original)
            } else {
                groups[sorted] = [original]
            }
        }
        return groups.map(\.value)
    }
    
    func groupAnagrams_showing_off(_ strs: [String]) -> [[String]] {
        Dictionary(
            grouping: strs,
            by: { $0.sorted() }
        ).values.map { $0 }
    }
    
    func groupAnagrams_very_slow(_ strs: [String]) -> [[String]] {
        var groups: [[Character: Int]: [String]] = [:]
        for string in strs {
            let dict = toDict(string)
            if let array = groups[dict] {
                groups[dict] = array + [string]
            } else {
                groups[dict] = [string]
            }
        }
        return Array(groups.values)
    }
    
    // From 242
    
    func toDict(_ input: String) -> [Character: Int] {
        var dict: [Character: Int] = [:]
        for char in input {
            let count = dict[char] ?? 0
            dict[char] = count + 1
        }
        return dict
    }
}
