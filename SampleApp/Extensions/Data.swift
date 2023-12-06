//
//  Data.swift
//  SampleApp
//
//  Created by 池守和槻 on 2023/12/06.
//
import Foundation

// extension Data {
//    /// Creates a new buffer by copying the buffer pointer of the given array.
//    ///
//    /// - Warning: The given array's element type `T` must be trivial in that it can be copied bit
//    ///     for bit with no indirection or reference-counting operations; otherwise, reinterpreting
//    ///     data from the resulting buffer has undefined behavior.
//    /// - Parameter array: An array with elements of type `T`.
//    init<T>(copyingBufferOf array: [T]) {
//        self = array.withUnsafeBufferPointer(Data.init)
//    }
//
//    /// Convert a Data instance to Array representation.
//    public func toArray<T>(type: T.Type) -> [T] where T: ExpressibleByIntegerLiteral {
//        var array = [T](repeating: 0, count: self.count / MemoryLayout<T>.stride)
//        _ = array.withUnsafeMutableBytes { copyBytes(to: $0) }
//        return array
//    }
// }
