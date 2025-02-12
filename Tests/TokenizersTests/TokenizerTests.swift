import XCTest
@testable import Tokenizers

final class TokenizerTests: XCTestCase {
    func testBasicTokenization() throws {
        print("===== testBasicTokenization =====")
        let tokenizer = try Tokenizer.from(pretrained: "bert-base-uncased")
        let encoding = try tokenizer.encode(input: "Hello, world!")
        
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
        let tokenizer = try Tokenizer.from(pretrained: "mlx-community/Phi-3-mini-4k-instruct-4bit-no-q-embed")
        let encoding = try tokenizer.encode(input: " Hi")

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
        let tokenizer = try Tokenizer.from(pretrained: "intfloat/multilingual-e5-small")
        let encoding = try tokenizer.encode(input: "query: how much protein should a female eat")
        print(encoding.ids)
        
        let decoded = try tokenizer.decode(encoding.ids)
        print(decoded)
        XCTAssertEqual(encoding.ids, [0, 41, 1294, 12, 3642, 5045, 21308, 5608, 10, 117776, 73203, 2])
    }

    //https://github.com/huggingface/swift-transformers/issues/107
    func testNLLBTokenizer() async throws {
        print("===== testNLLBTokenizer =====")
        let tokenizer = try Tokenizer.from(pretrained: "facebook/nllb-200-distilled-600M")
        let encoding = try tokenizer.encode(input: "how much wood could a woodchuck chuck?")
        XCTAssertFalse(encoding.tokens.isEmpty)
        print(encoding.ids)
        
        let decoded = try tokenizer.decode(encoding.ids)
        print(decoded)
        XCTAssertFalse(decoded.isEmpty)
    }
    
}

class BertDiacriticsTests: XCTestCase {
    func testBertCased() async throws {
        let tokenizer = try AutoTokenizer.from(pretrained: "distilbert/distilbert-base-multilingual-cased")
        
        let encoding = try tokenizer.encode(input: "mąka")
        XCTAssertEqual(encoding.ids, [101, 181, 102075, 10113, 102])
    }
    
    func testBertCasedResaved() async throws {
        let tokenizer = try AutoTokenizer.from(pretrained: "pcuenq/distilbert-base-multilingual-cased-tokenizer")
        
        let encoding = try tokenizer.encode(input: "mąka")
        XCTAssertEqual(encoding.ids, [101, 181, 102075, 10113, 102])
    }
    
    func testBertUncased() async throws {
        let tokenizer = try AutoTokenizer.from(pretrained: "google-bert/bert-base-uncased")
        
        do {
            let maka = try tokenizer.encode(input: "mąka")
            XCTAssertEqual(maka.ids, [101, 5003, 2912, 102])
            
            let dept = try tokenizer.encode(input: "département")
            XCTAssertEqual(dept.ids, [101, 18280, 13665, 102])
        } catch {
            XCTFail("Encoding failed with error: \(error)")
        }
    }
}
