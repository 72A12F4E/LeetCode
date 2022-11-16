// I initially had something a bit more complex with some helper methods, but it 
// exceeded runtime for the grader.

class Bank {

    private var accounts: [Int]
    
    init(_ accounts: [Int]) {
        self.accounts = accounts
    }
    
    func transfer(_ account1: Int, _ account2: Int, _ money: Int) -> Bool {
        guard account1 <= accounts.count,
              account2 <= accounts.count,
            accounts[account1 - 1] >= money
        else {
            return false
        }
        accounts[account1 - 1] -= money
        accounts[account2 - 1] += money
        
        return true
    }
    
    func deposit(_ account: Int, _ money: Int) -> Bool {
        guard account <= accounts.count else { return false }
        accounts[account - 1] += money
        return true
    }
    
    func withdraw(_ account: Int, _ money: Int) -> Bool {
        guard account <= accounts.count,
            accounts[account - 1] >= money
        else {
            return false
        }
        accounts[account - 1] -= money
        return true
    }
}
