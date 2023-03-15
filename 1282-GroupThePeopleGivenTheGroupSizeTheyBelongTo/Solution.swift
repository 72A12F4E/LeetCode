/// There are n people that are split into some unknown number of groups. Each
/// person is labeled with a unique ID from 0 to n - 1.
///
/// You are given an integer array groupSizes, where groupSizes[i] is the size of
/// the group that person i is in. For example, if groupSizes[1] = 3, then person 1
/// must be in a group of size 3.
///
/// Return a list of groups such that each person i is in a
/// group of size groupSizes[i].
///
/// Each person should appear in exactly one group, and every person must be
/// in a group. If there are multiple answers, return any of them. It is guaranteed
/// that there will be at least one valid solution for the given input.

/// organize your data
struct Person {
    let id: Int
    let groupSize: Int
}

class Solution {
    func groupThePeople_naiveFirstApproach(_ groupSizes: [Int]) -> [[Int]] {
        // Generate list of people
        var people = groupSizes.enumerated().map { (offset, element) in
            Person(id: offset, groupSize: element)
        }
        // find the largest group size
        let limit = people.map(\.groupSize).max()!
        var groups: [[Int]] = []
        
        for size in 1...limit {
            // If we have people that can fit in this group
            // size, start adding them to the groups. Otherwise
            // move to next group size
            if people.contains(where: {$0.groupSize == size}) {
                groups.append([])
            } else {
                continue
            }
            // select people that match the group size, and divide
            // those people into their groups
            for person in people where person.groupSize == size {
                if groups[groups.endIndex - 1].count < size {
                    groups[groups.endIndex - 1].append(person.id)
                } else {
                    groups.append([person.id])
                }
            }
        }
        
        return groups
    }

    func groupThePeople(_ groupSizes: [Int]) -> [[Int]] {
        // Generate list of people
        var people = groupSizes.enumerated().map { (offset, element) in
            Person(id: offset, groupSize: element)
        }.sorted {
            // sorting groupSize in descending order 
            // makes the size check for group size work
            // when we are splitting people into groups
            $0.groupSize > $1.groupSize 
        }

        var groups: [[Int]] = [[]]
        for person in people {
            if groups.last!.count < person.groupSize {
                groups[groups.endIndex - 1].append(person.id)
            } else {
                groups.append([person.id])
            }
        }
        
        return groups
    }

    func groupThePeople_optimized_ish(_ groupSizes: [Int]) -> [[Int]] {
        var groups: [[Int]] = [[]]
        for person in groupSizes.enumerated().sorted(by: { $0.1 > $1.1 }) {
            if groups.last!.count < person.1 {
                groups[groups.endIndex - 1].append(person.0)
            } else {
                groups.append([person.0])
            }
        }
        return groups
    }
}

