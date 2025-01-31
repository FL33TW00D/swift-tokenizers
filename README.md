# Experiments in expanding the surface area of Tokenizers

> Goal: Reduce maintenance burden by having "One True Tokenizer"™.

## Implementation

### Mozilla UniFFI

[UniFFI](https://github.com/mozilla/uniffi-rs) is used by Mozilla in production to generate Swift and Kotlin bindings for their apps.

### CBindgen

Use [CBindgen](https://github.com/mozilla/cbindgen) to generate a C bridging header from our Rust.

### Swift-Bridge

[swift-bridge](https://github.com/chinedufn/swift-bridge) - sole maintainer, follows the [CXX bridge pattern](https://cxx.rs/index.html).
From the initial experiments, promising but not ready.
