use std::error::Error;
use tokenizers::{Encoding, FromPretrainedParameters, Tokenizer};

#[swift_bridge::bridge]
mod ffi {
    extern "Rust" {
        type FromPretrainedParameters;
        type RustError;
        type Encoding;
    }

    extern "Rust" {
        type SwiftTokenizer;

        #[swift_bridge(associated_to = SwiftTokenizer)]
        fn from_pretrained(
            identifier: &str,
            revision: Option<FromPretrainedParameters>,
        ) -> Result<SwiftTokenizer, RustError>;

        fn encode(&self, input: &str, add_special_tokens: bool) -> Result<Encoding, RustError>;
    }
}

pub enum RustError {
    Io(std::io::Error),
    Tokenizers(tokenizers::Error),
    Any(Box<dyn Error>),
}

impl From<std::io::Error> for RustError {
    fn from(e: std::io::Error) -> Self {
        RustError::Io(e)
    }
}

impl From<tokenizers::Error> for RustError {
    fn from(e: tokenizers::Error) -> Self {
        RustError::Tokenizers(e)
    }
}

impl From<Box<dyn Error>> for RustError {
    fn from(e: Box<dyn Error>) -> Self {
        RustError::Any(e)
    }
}

pub struct SwiftTokenizer {
    pub(crate) tokenizer: Tokenizer,
}

impl SwiftTokenizer {
    pub fn from_pretrained(
        identifier: &str,
        revision: Option<FromPretrainedParameters>,
    ) -> Result<SwiftTokenizer, RustError> {
        let tokenizer = Tokenizer::from_pretrained(identifier, revision)?;
        Ok(Self { tokenizer })
    }

    pub fn encode(&self, input: &str, add_special_tokens: bool) -> Result<Encoding, RustError> {
        Ok(self.tokenizer.encode(input, add_special_tokens)?)
    }
}

/*
*     /// Encode the given input. This method accepts both single sequences, as well as pair
    /// sequences. Also, a sequence can be a string, or already pre-tokenized input directly:
    ///
    /// ```
    /// # use tokenizers::Tokenizer;
    /// # use tokenizers::models::bpe::BPE;
    /// # let mut tokenizer = Tokenizer::new(BPE::default());
    /// #
    /// // Sequences:
    /// tokenizer.encode("Single sequence", false);
    /// tokenizer.encode(("Sequence A", "Sequence B"), false);
    ///
    /// // Pre-tokenized sequences:
    /// tokenizer.encode(&["Single", "sequence"][..], false);
    /// tokenizer.encode((
    ///     &["Sequence", "A"][..],
    ///     &["Sequence", "B"][..]
    /// ), false);
    ///
    /// // or even both types together:
    /// tokenizer.encode(("A complete sequence", &["And", "a", "tokenized"][..]), false);
    /// ```
    pub fn encode<'s, E>(&self, input: E, add_special_tokens: bool) -> Result<Encoding>
    where
        E: Into<EncodeInput<'s>>,
    {
        // Extract sequences from the EncodeInput
        let (sequence, pair) = match input.into() {
            EncodeInput::Single(s1) => (s1, None),
            EncodeInput::Dual(s1, s2) => (s1, Some(s2)),
        };

        // Encode each sequence
        let encoding = self.encode_single_sequence(sequence, 0, OffsetType::Byte)?;
        let pair_encoding = pair
            .map(|sequence| self.encode_single_sequence(sequence, 1, OffsetType::Byte))
            .transpose()?;

        // And finally post process
        self.post_process(encoding, pair_encoding, add_special_tokens)
    }
*/
