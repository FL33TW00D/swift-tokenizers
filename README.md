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

## Build the project:
```bash
swift build
```

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

