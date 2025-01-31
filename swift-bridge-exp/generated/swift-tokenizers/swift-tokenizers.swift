
public class Encoding: EncodingRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$Encoding$_free(ptr)
        }
    }
}
public class EncodingRefMut: EncodingRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class EncodingRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension Encoding: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_Encoding$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_Encoding$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: Encoding) {
        __swift_bridge__$Vec_Encoding$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_Encoding$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (Encoding(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<EncodingRef> {
        let pointer = __swift_bridge__$Vec_Encoding$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return EncodingRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<EncodingRefMut> {
        let pointer = __swift_bridge__$Vec_Encoding$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return EncodingRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<EncodingRef> {
        UnsafePointer<EncodingRef>(OpaquePointer(__swift_bridge__$Vec_Encoding$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_Encoding$len(vecPtr)
    }
}


public class RustError: RustErrorRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$RustError$_free(ptr)
        }
    }
}
public class RustErrorRefMut: RustErrorRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class RustErrorRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension RustError: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_RustError$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_RustError$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: RustError) {
        __swift_bridge__$Vec_RustError$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_RustError$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (RustError(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<RustErrorRef> {
        let pointer = __swift_bridge__$Vec_RustError$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return RustErrorRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<RustErrorRefMut> {
        let pointer = __swift_bridge__$Vec_RustError$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return RustErrorRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<RustErrorRef> {
        UnsafePointer<RustErrorRef>(OpaquePointer(__swift_bridge__$Vec_RustError$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_RustError$len(vecPtr)
    }
}


public class FromPretrainedParameters: FromPretrainedParametersRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$FromPretrainedParameters$_free(ptr)
        }
    }
}
public class FromPretrainedParametersRefMut: FromPretrainedParametersRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class FromPretrainedParametersRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension FromPretrainedParameters: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_FromPretrainedParameters$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_FromPretrainedParameters$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: FromPretrainedParameters) {
        __swift_bridge__$Vec_FromPretrainedParameters$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_FromPretrainedParameters$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (FromPretrainedParameters(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FromPretrainedParametersRef> {
        let pointer = __swift_bridge__$Vec_FromPretrainedParameters$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FromPretrainedParametersRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FromPretrainedParametersRefMut> {
        let pointer = __swift_bridge__$Vec_FromPretrainedParameters$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FromPretrainedParametersRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<FromPretrainedParametersRef> {
        UnsafePointer<FromPretrainedParametersRef>(OpaquePointer(__swift_bridge__$Vec_FromPretrainedParameters$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_FromPretrainedParameters$len(vecPtr)
    }
}


public class SwiftTokenizer: SwiftTokenizerRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$SwiftTokenizer$_free(ptr)
        }
    }
}
extension SwiftTokenizer {
    class public func from_pretrained<GenericToRustStr: ToRustStr>(_ identifier: GenericToRustStr, _ revision: Optional<FromPretrainedParameters>) throws -> SwiftTokenizer {
        return identifier.toRustStr({ identifierAsRustStr in
            try { let val = __swift_bridge__$SwiftTokenizer$from_pretrained(identifierAsRustStr, { if let val = revision { val.isOwned = false; return val.ptr } else { return nil } }()); if val.is_ok { return SwiftTokenizer(ptr: val.ok_or_err!) } else { throw RustError(ptr: val.ok_or_err!) } }()
        })
    }
}
public class SwiftTokenizerRefMut: SwiftTokenizerRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class SwiftTokenizerRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension SwiftTokenizerRef {
    public func encode<GenericToRustStr: ToRustStr>(_ input: GenericToRustStr, _ add_special_tokens: Bool) throws -> Encoding {
        return input.toRustStr({ inputAsRustStr in
            try { let val = __swift_bridge__$SwiftTokenizer$encode(ptr, inputAsRustStr, add_special_tokens); if val.is_ok { return Encoding(ptr: val.ok_or_err!) } else { throw RustError(ptr: val.ok_or_err!) } }()
        })
    }
}
extension SwiftTokenizer: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_SwiftTokenizer$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_SwiftTokenizer$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: SwiftTokenizer) {
        __swift_bridge__$Vec_SwiftTokenizer$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_SwiftTokenizer$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (SwiftTokenizer(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<SwiftTokenizerRef> {
        let pointer = __swift_bridge__$Vec_SwiftTokenizer$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return SwiftTokenizerRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<SwiftTokenizerRefMut> {
        let pointer = __swift_bridge__$Vec_SwiftTokenizer$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return SwiftTokenizerRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<SwiftTokenizerRef> {
        UnsafePointer<SwiftTokenizerRef>(OpaquePointer(__swift_bridge__$Vec_SwiftTokenizer$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_SwiftTokenizer$len(vecPtr)
    }
}



