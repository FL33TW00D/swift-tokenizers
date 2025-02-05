#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct TokenizerHandle TokenizerHandle;

typedef struct EncodingResult {
  unsigned int *ids;
  char **tokens;
  unsigned int *attention_mask;
  unsigned int *type_ids;
  unsigned int *special_tokens_mask;
  uintptr_t length;
} EncodingResult;

/**
 * Frees the tokenizer handle
 *
 * # Safety
 * Handle must be a valid TokenizerHandle
 */
void tokenizer_free(struct TokenizerHandle *handle);

/**
 * Creates a new tokenizer from a pretrained model identifier
 *
 * # Safety
 * Name must be a valid C string
 * Returns a pointer to the TokenizerHandle
 * The caller is responsible for freeing the memory using tokenizer_free()
 */
struct TokenizerHandle *tokenizer_from_pretrained(const char *name);

/**
 * Encodes text using the given tokenizer
 *
 * # Safety
 * Handle must be a valid TokenizerHandle
 * Text must be a valid C string
 */
struct EncodingResult *tokenizer_encode(struct TokenizerHandle *handle,
                                        const char *text,
                                        bool add_special_tokens);

/**
 * Decodes a sequence of ids into a string
 *
 * # Safety
 * Handle must be a valid TokenizerHandle
 * Ids must be a valid array of c_uint
 * Length must be the length of the ids array
 *
 * # Returns
 * A pointer to the decoded string.
 */
char *tokenizer_decode(struct TokenizerHandle *handle,
                       const unsigned int *ids,
                       uintptr_t length,
                       bool skip_special_tokens);

void free_rstring(char *s);

/**
 * Frees the EncodingResult
 *
 * # Safety
 * Input must be a valid EncodingResult
 */
void encoding_result_free(struct EncodingResult *result);
