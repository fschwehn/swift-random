import XCTest
@testable import swift_random

final class DeterministicRandomTests: XCTestCase {
    func testShouldProduceConsistentResultsWithSameSeed() throws {
        let seed = Int.random(in: 0 ... .max)
        
        var random = DeterministicRandom(seed: seed)
        let resultA = (0 ..< 10).map { _ in Int.random(in: 0 ..< 1000, using: &random ) }
        
        random = DeterministicRandom(seed: seed)
        let resultB = (0 ..< 10).map { _ in Int.random(in: 0 ..< 1000, using: &random ) }
        
        XCTAssertEqual(resultA, resultB)
    }
    
    func testMultipleInstancesShouldNotAffectEachOtherWhenUsedInParallel() throws {
        let seed = Int.random(in: 0 ... .max)
        
        var randomA = DeterministicRandom(seed: seed)
        var randomB = DeterministicRandom(seed: seed)
        
        let resultA = (0 ..< 10).map { _ in Int.random(in: 0 ..< 1000, using: &randomA ) }
        let resultB = (0 ..< 10).map { _ in Int.random(in: 0 ..< 1000, using: &randomB ) }
        
        XCTAssertEqual(resultA, resultB)
    }
}
