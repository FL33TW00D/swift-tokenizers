if let tokenizer = Tokenizer.from_pretrained("bert-base-uncased") {
    let tokens = tokenizer.encode("Hello world!", true)
    for token in tokens {
        print(token)
    }
}
