import Foundation
import tokenizersFFI

@main
struct TokenizerTest {
    static func main() {
        do {
            // Create a tokenizer from a pre-trained model
            let tokenizer = try fromPretrained(identifier: "bert-base-uncased")
            
            // Test text
            let text = "Hello, world! How are you doing?"
            
            // Encode the text
            let encoding = try tokenizer.encode(text: text, addSpecialTokens: true)
            
            // Print results
            print("Original text:", text)
            print("Token IDs:", encoding.ids)
            print("Tokens:", encoding.tokens)
            
            // Decode back
            let decoded = try tokenizer.decode(ids: encoding.ids, skipSpecialTokens: true)
            print("Decoded text:", decoded)
            
        } catch {
            print("Error:", error)
        }
    }
}
