# Swift HuggingFace Tokenizers

A Swift implementation of HuggingFace tokenizers using a RUST -> C -> Swift bridge.

## ⚠️ EXPERIMENTAL WARNING

**This is an experimental implementation.** 
**Use the battle tested version from [Swift-Transformers](https://github.com/huggingface/swift-transformers).**

## Overview 

In contrast to the Tokenizer in `swift-transformers`, this implementation uses
the original Rust [Tokenizers](https://github.com/huggingface/tokenizers) as
its core. We then use `cbindgen` to generate C headers from the Rust code, which
can then be imported into Swift.

```
RUST (Core Tokenizer) -> C (Bridge) -> Swift (API)
```

## Build the project
Only works on ARM Macs today, common sense required to build for other platforms (`dylib` -> `so` etc etc).


1. Clone [tokenizers-sys](https://github.com/FL33TW00D/tokenizers-sys/tree/master)
2. Run `./compile-ex.sh`
3. Check that `/target/release/libtokenizers_sys.dylib` exists
4. Clone [swift-tokenizers](https://github.com/FL33TW00D/swift-tokenizers/tree/master)
5. `cp ~/tokenizers-sys/target/release/libtokenizers_sys.dylib ~/swift-tokenizers/dependencies`
6. `swift build`
7. `swift test`
8. 😎

## Usage

```swift
func NLLBTokenizer() async throws {
    let tokenizer = try Tokenizer.fromPretrained(name: "facebook/nllb-200-distilled-600M")
    let encoding = try tokenizer.encode("how much wood could a woodchuck chuck?")
    print(encoding.ids)
    let decoded = try tokenizer.decode(encoding.ids)
    print(decoded)
}
```

## Packaging

Right now this just links a `dylib` compiled from [tokenizers-sys](https://github.com/FL33TW00D/tokenizers-sys/tree/master), so resolving packaging for all platforms is another step to take.

## TODO
- [ ] Pass 100% of `swift-transformers` Tokenizer tests
- [ ] C API won't expose async, so we may want to use `Hub` package and avoid using `fromPretrained` from the Rust package.
- [ ] Cross platform packaging
- [ ] Drop in replacement for `swift-transformers` tokenizer
- [ ] Implement Chat Templates
