
class BrowserHistory {
    
    private var index: Int
    private var history: [String]

    init(_ homepage: String) {
        index = 0
        history = [homepage]
    }
    
    func visit(_ url: String) {
        history.removeLast(history.count - index - 1)
        history.append(url)
        index += 1
    }
    
    func back(_ steps: Int) -> String {
        index = max(0, index - steps)
        return history[index]
    }
    
    func forward(_ steps: Int) -> String {
        index = min(history.count - 1, index + steps)
        return history[index]
    }
}

let hist = BrowserHistory("leetcode.com")
hist.visit("google.com")
hist.visit("facebook.com")
hist.visit("youtube.com")
hist.back(1)
hist.back(1)
hist.forward(1)
hist.visit("linkedin.com")
hist.forward(2)
hist.back(2)
hist.back(7)
