import GameKit

public struct DeterministicRandom: RandomNumberGenerator {
    private let source: GKRandomSource

    public init(seed: Int? = nil) {
        let seedValue: UInt64
        
        if let seed = seed {
            seedValue = .init(bitPattern: Int64(seed))
        }
        else {
            seedValue = .random(in: .min ... .max)
        }
        
        self.source = GKMersenneTwisterRandomSource(seed: seedValue)
    }
    
    public mutating func next() -> UInt64 {
        UInt64(source.nextUniform() * Float(UINT64_MAX))
    }
}
