#include "bindings/ctokenizers.h"
#include <stdio.h>

int main() {
    TokenizerHandle* tokenizer = tokenizer_from_pretrained("bert-base-cased");
    if (!tokenizer) {
        printf("Failed to load tokenizer\n");
        return 1;
    }

    const char* text = "Hello, world!";
    EncodingResult* encoding = tokenizer_encode(tokenizer, text, true);
    if (!encoding) {
        printf("Encoding failed\n");
        tokenizer_free(tokenizer);
        return 1;
    }

    printf("Tokens:\n");
    for (size_t i = 0; i < encoding->length; i++) {
        printf("  %s (ID: %u, Type: %d, Special: %d, Attention: %d)\n",
               encoding->tokens[i],
               encoding->ids[i],
               encoding->type_ids[i],
               encoding->special_tokens_mask[i],
               encoding->attention_mask[i]);
    }

    char* decoded = tokenizer_decode(tokenizer, encoding->ids, encoding->length, true);
    if (decoded) {
        printf("\nDecoded text: %s\n", decoded);
        // FFI: He who allocs must dealloc i.e same side of FFI
        free_rstring(decoded);
    }

    encoding_result_free(encoding);
    tokenizer_free(tokenizer);
    return 0;
}
