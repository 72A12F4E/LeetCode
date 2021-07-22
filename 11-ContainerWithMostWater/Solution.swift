
class Solution {    
    func maxArea(_ height: [Int]) -> Int {
        var largest = -1
        var left = 0
        var right = height.count - 1

        while left != right {
            largest = max(largest, min(height[left], height[right]) * (right - left))
            if height[left] < height[right] {
                left += 1
            } else  {
                right -= 1
            }
        }
        
        return largest
    }
}

