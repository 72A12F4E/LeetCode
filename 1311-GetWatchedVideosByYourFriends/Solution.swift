
class Graph: CustomDebugStringConvertible {
    var graph: [Person] = []
    
    init(
        watchedVideos: [[String]],
        friends: [[Int]]
    ) {
        precondition(friends.count == watchedVideos.count)
        for index in 0..<friends.count {
            graph.append(
                .init(
                    id: index,
                    friends: friends[index],
                    watchedVideos: watchedVideos[index]
                )
            )
        }
    }
    
    var debugDescription: String {
        "Graph(\(graph))"
    }
}

class Person: CustomDebugStringConvertible {
    let id: Int
    let friendIds: [Int]
    let watchedVideos: [String]
    
    init(
        id: Int,
        friends: [Int],
        watchedVideos: [String]
    ) {
        self.id = id
        self.friendIds = friends
        self.watchedVideos = watchedVideos
    }
    
    var debugDescription: String {
        "Person(id: \(id), friendIds: \(friendIds), watchedVideos: \(watchedVideos))"
    }
    
    func isFriend(with other: Person) -> Bool {
        friendIds.contains(other.id)
    }
}

class Solution {
    func watchedVideosByFriends(
        _ watchedVideos: [[String]],
        _ friends: [[Int]],
        _ id: Int,
        _ level: Int
    ) -> [String] {
        let graph = Graph(watchedVideos: watchedVideos, friends: friends)

        // Initial conditions for the search starts at 
        // the individual at `id`
        var visitedIds: Set<Int> = [id]
        var current: [Person] = [graph.graph[id]]

        for _ in 0..<level {
            // Figure out next group of friends to visit
            current = graph.graph.filter { person in
                // haven't visited the person before, and
                // are a friend of someone in `current`
                !visitedIds.contains(person.id) &&
                current.contains(where: { currentFriend in
                    person.isFriend(with: currentFriend)
                })
            }
            
            // Mark current as visited so we don't loop back.
            visitedIds.formUnion(current.map(\.id))
        }

        // `current`` contains the population at level k 
        // do summation of results
        var results: [String: Int] = [:]
        for person in current {
            for video in person.watchedVideos {
                if let count = results[video] {
                    results[video] = count + 1
                } else {
                    results[video] = 1
                }
            }
        }
        
        // sort & return
        return results.sorted { lhs, rhs in
            lhs.key < rhs.key
        }.sorted { lhs, rhs in
            lhs.value < rhs.value
        }
        .map(\.key)
    }
}
