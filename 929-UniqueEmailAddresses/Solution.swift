import Foundation

class Solution {
    func numUniqueEmails(_ emails: [String]) -> Int {
        Set(emails.map(normalize(_:))).count
    }
    
    func normalize(_ email: String) -> String {
        let components = email.split(separator: "@")
        let localName = components[0].split(separator: "+")[0]
        let local = localName.filter { $0 != "." }
        return local + "@" + components[1]
    }
}

let solution = Solution()
// 2
solution.numUniqueEmails([
    "test.email+alex@leetcode.com",
    "test.e.mail+bob.cathy@leetcode.com",
    "testemail+david@lee.tcode.com"
])

// 3
solution.numUniqueEmails(["a@leetcode.com","b@leetcode.com","c@leetcode.com"])
