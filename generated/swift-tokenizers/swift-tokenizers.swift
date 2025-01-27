
public class Tokenizer: TokenizerRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$Tokenizer$_free(ptr)
        }
    }
}
extension Tokenizer {
    class public func from_pretrained<GenericToRustStr: ToRustStr>(_ model_name: GenericToRustStr) -> Optional<Tokenizer> {
        return model_name.toRustStr({ model_nameAsRustStr in
            { let val = __swift_bridge__$Tokenizer$from_pretrained(model_nameAsRustStr); if val != nil { return Tokenizer(ptr: val!) } else { return nil } }()
        })
    }
}
public class TokenizerRefMut: TokenizerRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class TokenizerRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension TokenizerRef {
    public func encode<GenericToRustStr: ToRustStr>(_ text: GenericToRustStr, _ add_special_tokens: Bool) -> RustVec<RustString> {
        return text.toRustStr({ textAsRustStr in
            RustVec(ptr: __swift_bridge__$Tokenizer$encode(ptr, textAsRustStr, add_special_tokens))
        })
    }

    public func encode_to_ids<GenericToRustStr: ToRustStr>(_ text: GenericToRustStr, _ add_special_tokens: Bool) -> RustVec<UInt32> {
        return text.toRustStr({ textAsRustStr in
            RustVec(ptr: __swift_bridge__$Tokenizer$encode_to_ids(ptr, textAsRustStr, add_special_tokens))
        })
    }

    public func decode(_ ids: UnsafeBufferPointer<UInt32>, _ skip_special_tokens: Bool) -> RustString {
        RustString(ptr: __swift_bridge__$Tokenizer$decode(ptr, ids.toFfiSlice(), skip_special_tokens))
    }
}
extension Tokenizer: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_Tokenizer$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_Tokenizer$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: Tokenizer) {
        __swift_bridge__$Vec_Tokenizer$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_Tokenizer$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (Tokenizer(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<TokenizerRef> {
        let pointer = __swift_bridge__$Vec_Tokenizer$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return TokenizerRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<TokenizerRefMut> {
        let pointer = __swift_bridge__$Vec_Tokenizer$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return TokenizerRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<TokenizerRef> {
        UnsafePointer<TokenizerRef>(OpaquePointer(__swift_bridge__$Vec_Tokenizer$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_Tokenizer$len(vecPtr)
    }
}



