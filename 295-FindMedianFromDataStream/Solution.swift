import Foundation

// Turns out Swift is fast enough to naively pass all the tests... 🤷‍♂️

class MedianFinder {
    private var nums: [Int] = []
    
    init() {}
    
    func addNum(_ num: Int) {
        nums.append(num)
    }
    
    func findMedian() -> Double {
        nums.sort()
        let mid = nums.count / 2
        if nums.count.isMultiple(of: 2) {
            let a = nums[mid - 1]
            let b = nums[mid]
            return (Double(a) + Double(b)) / 2.0
        } else {
            return Double(nums[mid])
        }
    }
}