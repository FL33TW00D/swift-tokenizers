if let tokenizer = Tokenizer.from_pretrained("bert-base-uncased") {
    let tokens = tokenizer.encode_to_ids("Hello world!", true)
    for token in tokens {
        print(token)
    }
}
