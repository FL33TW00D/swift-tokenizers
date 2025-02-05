use std::ffi::{c_char, c_uint, CStr, CString};
use std::ptr;
use tokenizers::tokenizer::Tokenizer;

//Opaque struct to hide Tokenizer internals
pub struct TokenizerHandle(*mut Tokenizer);

/// Frees the tokenizer handle
///
/// # Safety
/// Handle must be a valid TokenizerHandle
#[no_mangle]
pub unsafe extern "C" fn tokenizer_free(handle: *mut TokenizerHandle) {
    if !handle.is_null() {
        let tokenizer_handle = unsafe { Box::from_raw(handle) };
        let _ = unsafe { Box::from_raw(tokenizer_handle.0) };
    }
}

/// Creates a new tokenizer from a pretrained model identifier
///
/// # Safety
/// Name must be a valid C string
/// Returns a pointer to the TokenizerHandle
/// The caller is responsible for freeing the memory using tokenizer_free()
#[no_mangle]
pub unsafe extern "C" fn tokenizer_from_pretrained(name: *const c_char) -> *mut TokenizerHandle {
    if name.is_null() {
        return ptr::null_mut();
    }

    let c_name = match unsafe { CStr::from_ptr(name).to_str() } {
        Ok(s) => s,
        Err(_) => return ptr::null_mut(),
    };

    //TODO: add params instead of None
    match Tokenizer::from_pretrained(c_name, None) {
        Ok(tokenizer) => {
            let handle = Box::new(TokenizerHandle(Box::into_raw(Box::new(tokenizer))));
            Box::into_raw(handle)
        }
        Err(_) => ptr::null_mut(),
    }
}

/// Encodes text using the given tokenizer
///
/// # Safety
/// Handle must be a valid TokenizerHandle
/// Text must be a valid C string
#[no_mangle]
pub unsafe extern "C" fn tokenizer_encode(
    handle: *mut TokenizerHandle,
    text: *const c_char,
    add_special_tokens: bool,
) -> *mut EncodingResult {
    let tokenizer = unsafe {
        if handle.is_null() {
            return ptr::null_mut();
        }
        &mut *(*handle).0
    };

    let text = match unsafe { CStr::from_ptr(text).to_str() } {
        Ok(s) => s,
        Err(_) => return ptr::null_mut(),
    };

    match tokenizer.encode(text, add_special_tokens) {
        Ok(encoding) => {
            let u32_to_c_uint =
                |u: &[u32]| -> Vec<c_uint> { u.iter().map(|&id| id as c_uint).collect() };

            let ids = u32_to_c_uint(encoding.get_ids());
            let attention_mask = u32_to_c_uint(encoding.get_attention_mask());
            let type_ids = u32_to_c_uint(encoding.get_type_ids());
            let special_tokens_mask = u32_to_c_uint(encoding.get_special_tokens_mask());
            let tokens = encoding.get_tokens();

            // Convert tokens to C strings
            let c_tokens: Vec<*mut c_char> = tokens
                .iter()
                .map(|s| CString::new(s.as_str()).unwrap().into_raw())
                .collect();

            // Allocate and copy arrays
            let result = Box::new(EncodingResult {
                tokens: Box::into_raw(c_tokens.into_boxed_slice()) as *mut *mut c_char,
                attention_mask: Box::into_raw(attention_mask.into_boxed_slice()) as *mut c_uint,
                type_ids: Box::into_raw(type_ids.into_boxed_slice()) as *mut c_uint,
                special_tokens_mask: Box::into_raw(special_tokens_mask.into_boxed_slice())
                    as *mut c_uint,
                length: ids.len(),
                ids: Box::into_raw(ids.into_boxed_slice()) as *mut c_uint,
            });

            Box::into_raw(result)
        }
        Err(_) => ptr::null_mut(),
    }
}

/// Decodes a sequence of ids into a string
///
/// # Safety
/// Handle must be a valid TokenizerHandle
/// Ids must be a valid array of c_uint
/// Length must be the length of the ids array
///
/// # Returns
/// A pointer to the decoded string.
#[no_mangle]
pub unsafe extern "C" fn tokenizer_decode(
    handle: *mut TokenizerHandle,
    ids: *const c_uint,
    length: usize,
    skip_special_tokens: bool,
) -> *mut c_char {
    assert!(length > 0, "Length must be greater than 0");
    let tokenizer = unsafe {
        if handle.is_null() {
            return ptr::null_mut();
        }
        &mut *(*handle).0
    };

    let ids_slice = unsafe { std::slice::from_raw_parts(ids, length) };
    match tokenizer.decode(ids_slice, skip_special_tokens) {
        Ok(text) => match CString::new(text) {
            Ok(s) => s.into_raw(),
            Err(_) => ptr::null_mut(),
        },
        Err(_) => ptr::null_mut(),
    }
}

#[no_mangle]
pub unsafe extern "C" fn free_rstring(s: *mut c_char) {
    if !s.is_null() {
        let _ = CString::from_raw(s);
    }
}

#[repr(C)]
pub struct EncodingResult {
    ids: *mut c_uint,
    tokens: *mut *mut c_char,
    attention_mask: *mut c_uint,
    type_ids: *mut c_uint,
    special_tokens_mask: *mut c_uint,
    length: usize,
}

/// Frees the EncodingResult
///
/// # Safety
/// Input must be a valid EncodingResult
#[no_mangle]
pub unsafe extern "C" fn encoding_result_free(result: *mut EncodingResult) {
    if !result.is_null() {
        let r = unsafe { Box::from_raw(result) };
        let len = r.length;

        // Free arrays
        unsafe {
            let _ids = Box::from_raw(std::slice::from_raw_parts_mut(r.ids, len));
            let _attn = Box::from_raw(std::slice::from_raw_parts_mut(r.attention_mask, len));
            let _type_ids = Box::from_raw(std::slice::from_raw_parts_mut(r.type_ids, len));
            let _special =
                Box::from_raw(std::slice::from_raw_parts_mut(r.special_tokens_mask, len));

            let tokens = Box::from_raw(std::slice::from_raw_parts_mut(r.tokens, len));
            for token in tokens.iter() {
                let _ = CString::from_raw(*token);
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_ffi_basics() -> anyhow::Result<()> {
        unsafe {
            let handle = tokenizer_from_pretrained(std::ptr::null());
            assert!(handle.is_null());

            let model = CString::new("bert-base-uncased").map_err(|n| anyhow::anyhow!(n))?;
            let handle = tokenizer_from_pretrained(model.as_ptr());
            let text = CString::new("Hello world!").map_err(|n| anyhow::anyhow!(n))?;
            let encoding = tokenizer_encode(handle, text.as_ptr(), true);
            encoding_result_free(encoding);
            tokenizer_free(handle);

            Ok(())
        }
    }
}
