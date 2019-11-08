# Abstract Algebra in Swift

A non-optimized (seriously, performance is probably terribble) playground for Abtract Algebra in Swift.

# `IntegersModN`

> N non-negative integers form a group under multiplication modulo n, called the multiplicative group of [integers modulo n](https://en.wikipedia.org/wiki/Multiplicative_group_of_integers_modulo_n)

```swift
let z5 = IntegersModN(n: 5)

// Convenience, for tests
lazy var zero = z5.element(0)
lazy var one = z5.element(1)
lazy var two = z5.element(2)
lazy var three = z5.element(3)
lazy var four = z5.element(4)

func testIdentityIs0() {
    XCTAssertEqual(z5.identity, zero)
}

func testInverseOfZ5() {
    XCTAssertEqual(z5.inverse(of: one), four)
    XCTAssertEqual(z5.inverse(of: two), three)
    XCTAssertEqual(z5.inverse(of: three), two)
    XCTAssertEqual(z5.inverse(of: four), one)
}

func testOrder() {
    XCTAssertEqual(z5.order, 5)
}
```

# `SymmetricGroupOfIntegers`

> In abstract algebra, the symmetric group defined over any set is the group
whose elements are all the bijections from the set to itself, and whose
group operation is the composition of functions. In particular, the finite
[symmetric group](https://en.wikipedia.org/wiki/Symmetric_group) `S_n` defined over a finite set of n symbols consists of the
permutation operations that can be performed on the n symbols.

```swift
let S5 = SymmetricGroupOfIntegers(oneThrough: 5)

func testElementNoInGroup() {
    XCTAssertFalse(
        S5.isElementInGroup(S5.oneLine([1, 2, 3, 4, 5, 6]))
    )
}

func testInverseOfSymmetricGroup() {
    let f = S5.oneLine([3, 2, 1, 5, 4])

    // `f` in reversed order
    let expectedInverse = S5.oneLine([4, 5, 1, 2, 3])

    let inverse = S5.inverse(of: f)
    XCTAssertEqual(inverse, expectedInverse)
}

func testFunctionCompositionOnOneLineNotation() {
    let f = S5.oneLine([3, 2, 1, 5, 4])
    let g = S5.oneLine([2, 5, 4, 3, 1])
    let f_o_g = S5.functionComposition(f: f, g: g)
    XCTAssertEqual(f_o_g, S5.oneLine([2, 4, 5, 1, 3]))
    XCTAssertEqual(f_o_g, f * g)
}

func testFunctionCompositiononCyclicNotation() {
    let f = S5.cyclic([[1, 3], [4, 5], [2]])
    let g = S5.cyclic([[1, 2, 5], [3, 4]])
    let f_o_g = S5.functionComposition(f: f, g: g)
    XCTAssertEqual(f_o_g, S5.oneLine([2, 4, 5, 1, 3]))
}

func testFunctionCompositionWithIdentityResultsInElement() {
    let f = S5.oneLine([3, 2, 1, 5, 4])
    let f_o_g = S5.functionComposition(f: f, g: S5.identity)
    XCTAssertEqual(f_o_g, f)
}
```