import XCTest
@testable import Tokenizers

final class TokenizerTests: XCTestCase {
    func testBasicTokenization() throws {
        print("===== testBasicTokenization =====")
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
        print("===== testMatchesPythonTokenization =====")
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

    //https://github.com/huggingface/swift-transformers/issues/99
    func testE5() async throws {
        print("===== testE5 =====")
        let tokenizer = try Tokenizer.fromPretrained(name: "intfloat/multilingual-e5-small")
        let encoding = try tokenizer.encode("query: how much protein should a female eat")
        print(encoding.ids)
        
        let decoded = try tokenizer.decode(encoding.ids)
        print(decoded)
        XCTAssertEqual(encoding.ids, [0, 41, 1294, 12, 3642, 5045, 21308, 5608, 10, 117776, 73203, 2])
    }

    //https://github.com/huggingface/swift-transformers/issues/107
    func testNLLBTokenizer() async throws {
        print("===== testNLLBTokenizer =====")
        let tokenizer = try Tokenizer.fromPretrained(name: "facebook/nllb-200-distilled-600M")
        let encoding = try tokenizer.encode("how much wood could a woodchuck chuck?")
        XCTAssertFalse(encoding.tokens.isEmpty)
        print(encoding.ids)
        
        let decoded = try tokenizer.decode(encoding.ids)
        print(decoded)
        XCTAssertFalse(decoded.isEmpty)
    }
    
}
