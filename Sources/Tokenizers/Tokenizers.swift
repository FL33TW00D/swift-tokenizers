import Foundation
import CTokenizers

public enum TokenizerError: Error {
    case initializationFailed
    case encodingFailed
    case decodingFailed
}

//https://www.swift.org/documentation/articles/wrapping-c-cpp-library-in-swift.html
public class Encoding {
    private let encoding: OpaquePointer
    
    init(encoding: OpaquePointer) {
        self.encoding = encoding
    }
    
    deinit {
        encoding_free(encoding)
    }
    
    public var ids: [UInt32] {
        var length: UInt = 0
        guard let idsPtr = encoding_get_ids(encoding, &length) else {
            return []
        }
        return Array(UnsafeBufferPointer(start: idsPtr, count: Int(length)))
    }
    
    public var tokens: [String] {
        var length: UInt = 0
        guard let tokensPtr = encoding_get_tokens(encoding, &length) else {
            return []
        }
        // Create a buffer pointer to safely access the array of C strings
        let buffer = UnsafeBufferPointer(
            start: tokensPtr,
            count: Int(length)
        ).map { $0 }
        
        let tokens = buffer.compactMap { ptr -> String? in
            guard let ptr = ptr else { return nil }
            return String(cString: ptr)
        }
        
        free_c_char_array(tokensPtr, length)
        return tokens
    }
    
    public var attentionMask: [UInt32] {
        var length: UInt = 0
        guard let maskPtr = encoding_get_attention_mask(encoding, &length) else {
            return []
        }
        return Array(UnsafeBufferPointer(start: maskPtr, count: Int(length)))
    }
    
    public var specialTokensMask: [UInt32] {
        var length: UInt = 0
        guard let maskPtr = encoding_get_special_tokens_mask(encoding, &length) else {
            return []
        }
        return Array(UnsafeBufferPointer(start: maskPtr, count: Int(length)))
    }
    
    public var typeIds: [UInt32] {
        var length: UInt = 0
        guard let idsPtr = encoding_get_type_ids(encoding, &length) else {
            return []
        }
        return Array(UnsafeBufferPointer(start: idsPtr, count: Int(length)))
    }
    
    public var overflowing: [Encoding] {
        var length: UInt = 0
        guard let overflowPtr = encoding_get_overflowing(encoding, &length) else {
            return []
        }
        
        let overflow = (0..<Int(length)).map { index in
            Encoding(encoding: UnsafeRawPointer(overflowPtr)
                .advanced(by: index * MemoryLayout<OpaquePointer>.stride)
                .load(as: OpaquePointer.self))
        }
        
        free_encoding_array(overflowPtr, length)
        return overflow
    }
}

public class Tokenizer {
    private var handle: OpaquePointer
    
    private init(handle: OpaquePointer) {
        self.handle = handle
    }
    
    deinit {
        tokenizer_free(handle)
    }
    
    /// Create a tokenizer from a pretrained model
    /// - Parameters:
    ///   - name: The name of the pretrained model
    ///   - revision: Optional model revision
    ///   - token: Optional authentication token
    /// - Throws: TokenizerError if initialization fails
    public static func fromPretrained(
        name: String,
        revision: String? = nil,
        token: String? = nil
    ) throws -> Tokenizer {
        var params = CFromPretrainedParameters(
            revision: revision?.utf8CString.withUnsafeBufferPointer { $0.baseAddress },
            token: token?.utf8CString.withUnsafeBufferPointer { $0.baseAddress }
        )
        
        guard let handle = tokenizer_from_pretrained(name, &params) else {
            throw TokenizerError.initializationFailed
        }
        
        return Tokenizer(handle: handle)
    }
    
    /// Create a tokenizer from a file
    /// - Parameter path: Path to the tokenizer file
    /// - Throws: TokenizerError if initialization fails
    public static func fromFile(_ path: String) throws -> Tokenizer {
        guard let handle = tokenizer_from_file(path) else {
            throw TokenizerError.initializationFailed
        }
        return Tokenizer(handle: handle)
    }
    
    /// Create a tokenizer from a buffer containing a serialized tokenizer
    /// - Parameter buffer: Data containing the serialized tokenizer
    /// - Throws: TokenizerError if initialization fails
    public static func fromBuffer(_ buffer: Data) throws -> Tokenizer {
        return try buffer.withUnsafeBytes { bufferPtr in
            guard let handle = tokenizer_from_buffer(
                bufferPtr.baseAddress?.assumingMemoryBound(to: UInt8.self),
                UInt(buffer.count)
            ) else {
                throw TokenizerError.initializationFailed
            }
            return Tokenizer(handle: handle)
        }
    }
    
    /// Encode text into tokens
    /// - Parameters:
    ///   - text: The text to encode
    ///   - addSpecialTokens: Whether to add special tokens
    /// - Throws: TokenizerError if encoding fails
    /// - Returns: An Encoding object containing the results
    public func encode(
        _ text: String,
        addSpecialTokens: Bool = true
    ) throws -> Encoding {
        guard let encoding = tokenizer_encode(handle, text, addSpecialTokens) else {
            throw TokenizerError.encodingFailed
        }
        return Encoding(encoding: encoding)
    }
    
    /// Decode token IDs back into text
    /// - Parameters:
    ///   - ids: Array of token IDs to decode
    ///   - skipSpecialTokens: Whether to skip special tokens in the output
    /// - Throws: TokenizerError if decoding fails
    /// - Returns: The decoded text
    public func decode(
        _ ids: [UInt32],
        skipSpecialTokens: Bool = true
    ) throws -> String {
        return try ids.withUnsafeBufferPointer { buffer in
            guard let decoded = tokenizer_decode(
                handle,
                buffer.baseAddress,
                UInt(buffer.count),
                skipSpecialTokens
            ) else {
                throw TokenizerError.decodingFailed
            }
            let result = String(cString: decoded)
            free_rstring(decoded)
            return result
        }
    }
}
