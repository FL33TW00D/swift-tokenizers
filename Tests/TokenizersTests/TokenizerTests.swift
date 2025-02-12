import XCTest
@testable import Tokenizers

final class TokenizerTests: XCTestCase {
    func testBasicTokenization() throws {
        let tokenizer = try Tokenizer.fromPretrained(name: "bert-base-uncased")
        
        let input = "Hello, world!"
        let encoding = try tokenizer.encode(input)
        
        XCTAssertFalse(encoding.tokens.isEmpty)
        XCTAssertFalse(encoding.ids.isEmpty)
        print(encoding.tokens)
        print(encoding.ids)
        
        let decoded = try tokenizer.decode(encoding.ids)
        print(decoded)
        XCTAssertFalse(decoded.isEmpty)
    }

    //https://github.com/huggingface/swift-transformers/issues/96
    func testMatchesPythonTokenization() async throws {
        let tokenizer = try Tokenizer.fromPretrained(name: "mlx-community/Phi-3-mini-4k-instruct-4bit-no-q-embed")
        let input = " Hi"

        let encoding = try tokenizer.encode(input)

        let expectedOutput: [UInt32] = [1, 29871, 6324] 

        XCTAssertEqual(encoding.ids, expectedOutput)
        print(encoding.tokens)
        print(encoding.ids)

        let decoded = try tokenizer.decode(encoding.ids)
        print(decoded)
        XCTAssertFalse(decoded.isEmpty)
    }
    
}
