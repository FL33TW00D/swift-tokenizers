use std::ffi::{c_char, c_uint, CString};

#[repr(C)]
pub struct Encoding {
    pub(crate) ids: *mut c_uint,
    pub(crate) tokens: *mut *mut c_char,
    pub(crate) attention_mask: *mut c_uint,
    pub(crate) type_ids: *mut c_uint,
    pub(crate) special_tokens_mask: *mut c_uint,
    pub(crate) length: usize,
}

/// Frees the Encoding
///
/// # Safety
/// Input must be a valid Encoding
#[no_mangle]
pub unsafe extern "C" fn encoding_result_free(result: *mut Encoding) {
    if result.is_null() {
        return;
    }

    let r = unsafe { Box::from_raw(result) };

    unsafe {
        let _ = Box::from_raw(std::slice::from_raw_parts_mut(r.ids, r.length));
        let _ = Box::from_raw(std::slice::from_raw_parts_mut(r.attention_mask, r.length));
        let _ = Box::from_raw(std::slice::from_raw_parts_mut(r.type_ids, r.length));
        let _ = Box::from_raw(std::slice::from_raw_parts_mut(
            r.special_tokens_mask,
            r.length,
        ));

        let tokens = Box::from_raw(std::slice::from_raw_parts_mut(r.tokens, r.length));
        for token in tokens.iter() {
            let _ = CString::from_raw(*token);
        }
    }
}
