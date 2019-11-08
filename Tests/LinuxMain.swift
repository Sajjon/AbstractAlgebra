import XCTest

import AbstractAlgebraTests

var tests = [XCTestCaseEntry]()
tests += CollectionCountedTests.allTests()
tests += FiniteCyclicGroupOfIntegersModNTests.allTests()
tests += RotateArrayTests.allTests()
tests += ShiftArrayTests.allTests()
tests += SlidingWindowTests.allTests()

XCTMain(tests)
