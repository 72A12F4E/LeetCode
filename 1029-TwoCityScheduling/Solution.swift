
// Array Notes
// each row is a person
// row[0] is cityA cost
// row[1] is cityB cost
// Split the candidates evenly, and minimize cost

struct Person {
    let id: Int
    let cityACost: Int
    let cityBCost: Int
}

class Solution {
    func totalCost(_ cityA: [Person], _ cityB: [Person]) -> Int {
        cityA.reduce(0) { sum, person in
            sum + person.cityACost
        } + cityB.reduce(0) { sum, person in
            sum + person.cityBCost
        }
    }
    
    func twoCitySchedCost(_ costs: [[Int]]) -> Int {
        // Group people into their cheapest cities.
        let people = costs.enumerated().map { Person(id: $0, cityACost: $1[0], cityBCost: $1[1]) }
        var cityA: [Person] = []
        var cityB: [Person] = []
        for person in people {
            if person.cityACost < person.cityBCost {
                cityA.append(person)
            } else {
                cityB.append(person)
            }
        }

        // Sort groups such that the lowest opportunity
        // cost difference is at the end of the array.
        cityA.sort {
            $0.cityBCost - $0.cityACost > $1.cityBCost - $1.cityACost
        }
        cityB.sort {
            $0.cityACost - $0.cityBCost > $1.cityACost - $1.cityBCost
        }
 
        // Figure out how many suboptimal choices to
        // balance the two groups equally, and move
        // people based on optimality.
        let moves = abs((cityA.count - cityB.count) / 2)
        if cityA.count < cityB.count {
            cityA.append(contentsOf: cityB.suffix(moves))
            cityB.removeLast(moves)
        } else if cityA.count > cityB.count {
            cityB.append(contentsOf: cityA.suffix(moves))
            cityA.removeLast(moves)
        }
        
        return totalCost(cityA, cityB)
    }
}

let solution = Solution()
solution.twoCitySchedCost([[259,770],[448,54],[926,667],[184,139],[840,118],[577,469]])
