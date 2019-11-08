import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CollectionCountedTests.allTests),
        testCase(FiniteCyclicGroupOfIntegersModNTests.allTests),
        testCase(RotateArrayTests.allTests),
        testCase(ShiftArrayTests.allTests),
        testCase(SlidingWindowTests.allTests),

    ]
}
#endif
