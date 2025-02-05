use std::ffi::{c_char, CStr, CString};
use std::ptr;
use std::sync::{Arc, RwLock};

use tk::models::bpe::BPE;
use tk::models::wordlevel::WordLevel;
use tk::models::wordpiece::WordPiece;
use tk::models::ModelWrapper;
use tokenizers as tk;

//Opaque struct to hide Model internals
pub struct ModelHandle(*mut Arc<RwLock<ModelWrapper>>);

#[no_mangle]
pub unsafe extern "C" fn tk_model_free(model: *mut ModelHandle) {
    if !model.is_null() {
        let _ = Box::from_raw(model);
    }
}

#[no_mangle]
pub unsafe extern "C" fn tk_model_tokenize(
    model: *mut ModelHandle,
    sequence: *const c_char,
    tokens_ptr: *mut *mut c_char,
    n_tokens: *mut usize,
) -> bool {
    if model.is_null() || sequence.is_null() {
        return false;
    }

    let c_str = match CStr::from_ptr(sequence).to_str() {
        Ok(s) => s,
        Err(_) => return false,
    };

    true
}

#[no_mangle]
pub unsafe extern "C" fn tk_model_free_tokens(tokens: *mut *mut c_char, n_tokens: usize) {
    if !tokens.is_null() {
        let tokens_slice = std::slice::from_raw_parts(tokens, n_tokens);
        for &token in tokens_slice {
            drop(CString::from_raw(token));
        }
        drop(Vec::from_raw_parts(tokens, n_tokens, n_tokens));
    }
}

// BPE Functions

#[repr(C)]
pub struct BPEConfig {
    vocab_path: *const c_char,
    merges_path: *const c_char,
    cache_capacity: usize,
    dropout: f32,
    unk_token: *const c_char,
    continuing_subword_prefix: *const c_char,
    end_of_word_suffix: *const c_char,
    fuse_unk: bool,
    byte_fallback: bool,
}

#[no_mangle]
pub unsafe extern "C" fn tk_bpe_new(config: *const BPEConfig) -> *mut ModelHandle {
    if config.is_null() {
        return ptr::null_mut();
    }

    let config = &*config;

    // Require vocab and merges paths
    if config.vocab_path.is_null() || config.merges_path.is_null() {
        return ptr::null_mut();
    }

    let vocab_path = match CStr::from_ptr(config.vocab_path).to_str() {
        Ok(s) => s,
        Err(_) => return ptr::null_mut(),
    };

    let merges_path = match CStr::from_ptr(config.merges_path).to_str() {
        Ok(s) => s,
        Err(_) => return ptr::null_mut(),
    };

    let mut bpe = BPE::default();

    todo!()
}

// WordPiece Functions

#[repr(C)]
pub struct WordPieceConfig {
    vocab_path: *const c_char,
    unk_token: *const c_char,
    max_input_chars_per_word: usize,
    continuing_subword_prefix: *const c_char,
}

#[no_mangle]
pub unsafe extern "C" fn wordpiece_new(config: *const WordPieceConfig) -> *mut ModelHandle {
    if config.is_null() || (*config).vocab_path.is_null() {
        return ptr::null_mut();
    }

    let vocab_path = match CStr::from_ptr((*config).vocab_path).to_str() {
        Ok(s) => s,
        Err(_) => return ptr::null_mut(),
    };

    let mut wp = WordPiece::default();
    todo!()
}

// WordLevel Functions

#[repr(C)]
pub struct WordLevelConfig {
    vocab_path: *const c_char,
    unk_token: *const c_char,
}

#[no_mangle]
pub unsafe extern "C" fn wordlevel_new(config: *const WordLevelConfig) -> *mut ModelHandle {
    if config.is_null() || (*config).vocab_path.is_null() {
        return ptr::null_mut();
    }

    let vocab_path = match CStr::from_ptr((*config).vocab_path).to_str() {
        Ok(s) => s,
        Err(_) => return ptr::null_mut(),
    };

    let mut wl = WordLevel::default();

    todo!()
}

#[repr(C)]
pub struct UnigramVocabItem {
    token: *const c_char,
    score: f64,
}

#[no_mangle]
pub unsafe extern "C" fn tk_unigram_new(
    vocab: *const UnigramVocabItem,
    vocab_size: usize,
    unk_id: *const usize, //Optional
    byte_fallback: bool,
) -> *mut ModelHandle {
    if vocab.is_null() {
        return ptr::null_mut();
    }

    todo!()
}
