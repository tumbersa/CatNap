import CoreGraphics

public extension Int {
    /**
     * Ensures that the integer value stays with the specified range.
     */
    func clamped(_ range: Range<Int>) -> Int {
        return (self < range.lowerBound) ? range.lowerBound : ((self >= range.upperBound) ? range.upperBound - 1: self)
    }
    
    func clamped(_ range: ClosedRange<Int>) -> Int {
        return (self < range.lowerBound) ? range.lowerBound : ((self > range.upperBound) ? range.upperBound: self)
    }
    
    /**
     * Ensures that the integer value stays with the specified range.
     */
    @discardableResult
    mutating func clamp(_ range: Range<Int>) -> Int {
        self = clamped(range)
        return self
    }
    
    @discardableResult
    mutating func clamp(_ range: ClosedRange<Int>) -> Int {
        self = clamped(range)
        return self
    }
    
    /**
     * Ensures that the integer value stays between the given values, inclusive.
     */
    func clamped(_ v1: Int, _ v2: Int) -> Int {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
    
    /**
     * Ensures that the integer value stays between the given values, inclusive.
     */
    @discardableResult
    mutating func clamp(_ v1: Int, _ v2: Int) -> Int {
        self = clamped(v1, v2)
        return self
    }
}
