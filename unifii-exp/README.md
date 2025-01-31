
# Testing UniFFI

UniFFI from Mozilla is used to generate Swift bindings from Rust code.
Used in their production apps.

```bash
cargo build
cargo run --bin uniffi-bindgen --features=uniffi/cli generate src/tokenizers.udl --language swift
```
Should have built the bindings, next compile the module with `swiftc`:

```bash
swiftc \                                                                                                                                                                                                                                                            12:12:02
  -I ./src \
  -L ./target/debug \
  -luniffi_tokenizers \
  -Xcc -fmodule-map-file=src/tokenizersFFI.modulemap \
  src/tokenizers.swift \
  test_tokenizer.swift \
  -o test_tokenizer
```

Now we run it! 

```bash
./test_tokenizer
```

You should see some nice output:
```bash
~/Code/swift-tokenizers/unifii-exp master ❯ ./test_tokenizer                                                                                                                                                        
Original text: Hello, world! How are you doing?
Token IDs: [101, 7592, 1010, 2088, 999, 2129, 2024, 2017, 2725, 1029, 102]
Tokens: ["[CLS]", "hello", ",", "world", "!", "how", "are", "you", "doing", "?", "[SEP]"]
Decoded text: hello, world! how are you doing?
```


