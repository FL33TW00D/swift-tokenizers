use std::sync::Arc;
use tokenizers::tokenizer::Tokenizer as HFTokenizer;

#[derive(Debug)]
pub enum TokenizerError {
    LoadError,
    EncodeError,
    DecodeError,
}

impl std::fmt::Display for TokenizerError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            TokenizerError::LoadError => write!(f, "Error loading tokenizer"),
            TokenizerError::EncodeError => write!(f, "Error encoding text"),
            TokenizerError::DecodeError => write!(f, "Error decoding ids"),
        }
    }
}

impl From<tokenizers::Error> for TokenizerError {
    fn from(_: tokenizers::Error) -> Self {
        TokenizerError::LoadError
    }
}

#[derive(Debug)]
pub struct Encoding {
    pub ids: Vec<u32>,
    pub tokens: Vec<String>,
}

pub struct Tokenizer {
    inner: Arc<HFTokenizer>,
}

impl Tokenizer {
    pub fn from_pretrained(model_name: String) -> Result<Self, TokenizerError> {
        let tokenizer = HFTokenizer::from_pretrained(&model_name, None)
            .map_err(|_| TokenizerError::LoadError)?;
        Ok(Self {
            inner: Arc::new(tokenizer),
        })
    }

    pub fn encode(
        &self,
        text: String,
        add_special_tokens: bool,
    ) -> Result<Encoding, TokenizerError> {
        let encoding = self
            .inner
            .encode(text, add_special_tokens)
            .map_err(|_| TokenizerError::EncodeError)?;

        Ok(Encoding {
            ids: encoding.get_ids().to_vec(),
            tokens: encoding.get_tokens().to_vec(),
        })
    }

    pub fn decode(
        &self,
        ids: Vec<u32>,
        skip_special_tokens: bool,
    ) -> Result<String, TokenizerError> {
        self.inner
            .decode(&ids, skip_special_tokens)
            .map_err(|_| TokenizerError::DecodeError)
    }
}

uniffi::include_scaffolding!("tokenizers");

pub fn from_pretrained(identifier: String) -> Result<Arc<Tokenizer>, TokenizerError> {
    let tokenizer = Tokenizer::from_pretrained(identifier)?;
    Ok(Arc::new(tokenizer))
}
