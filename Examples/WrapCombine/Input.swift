import Foundation

struct SomeError: Error { }

// sourcery: wrapCombine
protocol SomeService {
    func simpleMethod() -> Int
    func throwingMethod() throws -> String
    // sourcery: wrapCombineErrorType=SomeError
    func throwingMethodWithRefinedError() throws
    func asyncThrowingMethod() async throws
    func asyncMethod() async -> (Int, String)
    func methodWithLabel(a: Int, b: String) -> String
    func methodWithNastyLabela(_ a: Int, with b: String) -> String
    func methodWithGenerics<T, U>(a: T) -> U
    func methodWithGenericsWhereClause<T>(a: Int) -> T where T: Equatable
}