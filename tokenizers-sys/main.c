#include "bindings/ctokenizers.h"
#include <stdio.h>

int main() {
    TokenizerHandle* tokenizer = tokenizer_from_pretrained("bert-base-cased");
    if (!tokenizer) {
        printf("Failed to load tokenizer\n");
        return 1;
    }

    const char* text = "Hello, world!";
    CEncoding* encoding = tokenizer_encode(tokenizer, text, true);
    if (!encoding) {
        printf("Encoding failed\n");
        tokenizer_free(tokenizer);
        return 1;
    }

    size_t length = encoding_get_length(encoding);
    const uint32_t* ids = encoding_get_ids(encoding, &length);
    const char* const* tokens = encoding_get_tokens(encoding, &length);
    const uint32_t* type_ids = encoding_get_type_ids(encoding, &length);
    const uint32_t* special_tokens_mask = encoding_get_special_tokens_mask(encoding, &length);
    const uint32_t* attention_mask = encoding_get_attention_mask(encoding, &length);

    printf("Tokens:\n");
    for (size_t i = 0; i < length; i++) {
        printf("  %s (ID: %u, Type: %d, Special: %d, Attention: %d)\n",
               tokens[i],
               ids[i],
               type_ids[i],
               special_tokens_mask[i],
               attention_mask[i]);
    }

    char* decoded = tokenizer_decode(tokenizer, ids, length, true);
    if (decoded) {
        printf("\nDecoded text: %s\n", decoded);
        free_rstring(decoded);  
    }

    encoding_free(encoding);  
    tokenizer_free(tokenizer);
    return 0;
}
