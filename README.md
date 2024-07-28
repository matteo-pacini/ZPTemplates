# ZPTemplates

ZPTemplates is a collection of templates for Sourcery to assist with Swift development. 

These templates aim to streamline and enhance the development process by automating code generation tasks.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Templates](#templates)
- [Contributing](#contributing)
- [License](#license)

## Installation

To get started with ZPTemplates, clone the repository to your local machine:

```bash
git clone https://github.com/matteo-pacini/ZPTemplates.git
```

## Usage

To use these Stencil templates with Sourcery, follow these steps:

1. **Install Sourcery** (if you haven't already):

    ```bash
    brew install sourcery
    ```

2. **Generate code** using the templates:

    ```bash
    sourcery --templates ./path-to-templates \
             --sources ./path-to-sources \
             --output ./path-to-output
    ```

## Templates

### WrapCombine

This template generates a protocol extension, where all
methods are wrapped for Combine (`Deferred` and `Future`).

This supports generics, `async` and `throws`.

To trigger it, annotate a protocol with `wrapCombine`, i.e.:

```swift
// sourcery: wrapCombine
protocol A {
    func test() async throws -> String
}

// ...will generate...

extension A {
    func test() -> AnyPublisher<String, any Error> {
        Deferred {
            Future { promise in
                Task {
                    do {
                        let result = try await test()
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
```

To refine the error type for a method, annotate it with `wrapCombineErrorType`, i.e:

```swift
// sourcery: wrapCombine
protocol A {
    // sourcery: wrapCombineErrorType=SomeError
    func test() async throws -> String
}

// ...will generate...

extension A {
    func test() -> AnyPublisher<String, SomeError> {
        Deferred {
            Future { promise in
                Task {
                    do {
                        let result = try await test()
                        promise(.success(result))
                    } catch let error as SomeError {
                        promise(.failure(error))
                    } catch {
                        fatalError("Unkown error propagated: \(String(describing: type(of: error)))")
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
```

## Contributing

Contributions are more than welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
