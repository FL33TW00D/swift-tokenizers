use tokenizers::Tokenizer as RustTokenizer;

#[swift_bridge::bridge]
mod ffi {
    extern "Rust" {
        type Tokenizer;

        #[swift_bridge(associated_to = Tokenizer)]
        fn from_pretrained(model_name: &str) -> Option<Tokenizer>;

        fn encode(&self, text: &str, add_special_tokens: bool) -> Vec<String>;
        fn encode_to_ids(&self, text: &str, add_special_tokens: bool) -> Vec<u32>;
        fn decode(&self, ids: &[u32], skip_special_tokens: bool) -> String;
    }
}

pub struct Tokenizer {
    inner: RustTokenizer,
}

impl Tokenizer {
    fn from_pretrained(model_name: impl ToString) -> Option<Self> {
        match RustTokenizer::from_pretrained(model_name.to_string(), None) {
            Ok(tokenizer) => Some(Tokenizer { inner: tokenizer }),
            Err(e) => {
                println!("Failed to load tokenizer: {}", e);
                None
            }
        }
    }

    pub fn encode(&self, text: &str, add_special_tokens: bool) -> Vec<String> {
        match self.inner.encode(text, add_special_tokens) {
            Ok(encoding) => encoding.get_tokens().to_vec(),
            Err(e) => {
                println!("Encoding error: {}", e);
                Vec::new()
            }
        }
    }

    pub fn encode_to_ids(&self, text: &str, add_special_tokens: bool) -> Vec<u32> {
        match self.inner.encode(text, add_special_tokens) {
            Ok(encoding) => encoding.get_ids().to_vec(),
            Err(e) => {
                println!("Encoding error: {}", e);
                Vec::new()
            }
        }
    }

    pub fn decode(&self, ids: &[u32], skip_special_tokens: bool) -> String {
        match self.inner.decode(ids, skip_special_tokens) {
            Ok(text) => text,
            Err(e) => {
                println!("Decoding error: {}", e);
                String::new()
            }
        }
    }
}
