//
//  OrderedSet.swift
//  AbstractAlgebra
//
//  Created by Alexander Cyon on 2019-07-14.
//  Copyright © 2019 Alex Cyon. All rights reserved.
//

import Foundation

public protocol OrderedSetType: RandomAccessCollection, Equatable where Element: Hashable {
    init()
    init(array: [Element])
    init(set: Set<Element>)
    init(single: Element)

    /// Returns the contents of the set as an array.
    var contents: [Element] { get }

    mutating func append(_ newElement: Element) -> Bool

    func contains(_ member: Element) -> Bool
}

public extension OrderedSetType {
    init(single: Element) {
        self.init(array: [single])
    }
}

/// An ordered set is an ordered collection of instances of `Element` in which
/// uniqueness of the objects is guaranteed.
///
/// Based on the Swift Package Managers `OrderedSet`, see [original source code in SPM Github repo][1]
///
/// [1]: https://github.com/apple/swift-package-manager/blob/master/Sources/Basic/OrderedSet.swift
///
public struct OrderedSet<Element>:
    OrderedSetType,
    ExpressibleByArrayLiteral,
    CustomStringConvertible
    where
    Element: Hashable
{

    private var array: [Element]
    private var set: Set<Element>

    /// Creates an empty ordered set.
    public init() {
        self.array = []
        self.set = Set()
    }
}

// MARK: Convenience Init
public extension OrderedSet {

    /// Creates an ordered set with the contents of `array`.
    ///
    /// If an element occurs more than once in `element`, only the first one
    /// will be included.
    init(array: [Element]) {
        self.init()
        for element in array {
            append(element)
        }
    }

    /// Creates an ordered set with the contents of `set`.
    init(set: Set<Element>) {
        self.init()
        for element in set {
            append(element)
        }
    }
}

// MARK: Typealias
public extension OrderedSet {
    typealias Index = Int
    typealias Indices = Range<Int>
}

// MARK: OrderedSetType
public extension OrderedSet {


    func contains(_ member: Element) -> Bool {
        return set.contains(member)
    }

//    func containsSameElements(as other: OrderedSet<Element>) -> Bool {
//        return self.set == other.set
//    }
//
//    func sorted(by sorting: (Element, Element) throws -> Bool) rethrows -> OrderedSet {
//        return OrderedSet(array: try array.sorted(by: sorting))
//    }
}

// MARK: Computed Properties
public extension OrderedSet {
    // MARK: Working with an ordered set

    /// The number of elements the ordered set stores.
    var count: Int { return array.count }

    /// Returns `true` if the set is empty.
    var isEmpty: Bool { return array.isEmpty }

    /// Returns the contents of the set as an array.
    var contents: [Element] { return array }
}


// MARK: Mutating functions
public extension OrderedSet {

    /// Adds an element to the ordered set.
    ///
    /// If it already contains the element, then the set is unchanged.
    ///
    /// - returns: True if the item was inserted.
    @discardableResult
    mutating func append(_ newElement: Element) -> Bool {
        let inserted = set.insert(newElement).inserted
        if inserted {
            array.append(newElement)
        }
        return inserted
    }

    /// Remove and return the element at the beginning of the ordered set.
    mutating func removeFirst() -> Element {
        let firstElement = array.removeFirst()
        set.remove(firstElement)
        return firstElement
    }

    /// Remove and return the element at the end of the ordered set.
    mutating func removeLast() -> Element {
        let lastElement = array.removeLast()
        set.remove(lastElement)
        return lastElement
    }

    /// Remove all elements.
    mutating func removeAll(keepingCapacity keepCapacity: Bool) {
        array.removeAll(keepingCapacity: keepCapacity)
        set.removeAll(keepingCapacity: keepCapacity)
    }
}

// MARK: ExpressibleByArrayLiteral
public extension OrderedSet {
    /// Create an instance initialized with `elements`.
    ///
    /// If an element occurs more than once in `element`, only the first one
    /// will be included.
    init(arrayLiteral elements: Element...) {
        self.init(array: elements)
    }
}


// MARK: CustomStringConvertible
public extension OrderedSet {

    var description: String {
        return array.description
    }
}

// MARK: RandomAccessCollection
public extension OrderedSet {
    var startIndex: Int { return contents.startIndex }
    var endIndex: Int { return contents.endIndex }
    subscript(index: Int) -> Element {
        return contents[index]
    }
}

// MARK: Equals
public func == <T>(lhs: OrderedSet<T>, rhs: OrderedSet<T>) -> Bool {
    return lhs.contents == rhs.contents
}

// MARK: OrderedSet + Hashable
extension OrderedSet: Hashable where Element: Hashable { }

// MARK: OrderSet Contains
public extension OrderedSetType where Element: OrderedSetType {
    func contains(permutationElement: Element.Element) -> Bool {
        return contents.first(where: { $0.contains(permutationElement) })?.isEmpty == false
    }

}

