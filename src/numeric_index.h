/*
 * Copyright Redis Ltd. 2016 - present
 * Licensed under your choice of the Redis Source Available License 2.0 (RSALv2) or
 * the Server Side Public License v1 (SSPLv1).
 */

#ifndef __NUMERIC_INDEX_H__
#define __NUMERIC_INDEX_H__

#include <stdio.h>
#include <stdlib.h>
#include "rmutil/vector.h"
#include "redisearch.h"
#include "index_result.h"
#include "redismodule.h"
#include "search_ctx.h"
#include "concurrent_ctx.h"
#include "inverted_index.h"
#include "numeric_filter.h"

#ifdef __cplusplus
extern "C" {
#endif

#define NR_CARD_CHECK 10

typedef struct {
  double value;
  size_t appearances;
} CardinalityValue;

/* A numeric range is a node in a numeric range tree, representing a range of
 * values bunched together.
 * Since we do not know the distribution of scores ahead, we use a splitting
 * approach - we start with single value nodes, and when a node passes some
 * cardinality we split it.
 * We save the minimum and maximum values inside the node, and when we split we
 * split by finding the median value.
 */
typedef struct {
  double minVal;
  double maxVal;

  double unique_sum;

  size_t invertedIndexSize;

  u_int16_t card;
  u_int16_t cardCheck;
  uint32_t splitCard;
  CardinalityValue *values;
  InvertedIndex *entries;
} NumericRange;

/* NumericRangeNode is a node in the range tree that can have a range in it or not, and can be a
 * leaf or not */
typedef struct rtNode {
  double value;
  int maxDepth;
  struct rtNode *left;
  struct rtNode *right;

  NumericRange *range;
} NumericRangeNode;

typedef struct {
  int sz;
  int numRecords;
  int changed;
  int numRanges;
} NRN_AddRv;

typedef struct {
  NumericRangeNode **nodesStack;
} NumericRangeTreeIterator;

/* The root tree and its metadata */
typedef struct {
  NumericRangeNode *root;
  size_t numRanges;
  size_t numEntries;
  size_t invertedIndexesSize;

  t_docId lastDocId;

  uint32_t revisionId;

  uint32_t uniqueId;

  size_t emptyLeaves;

} NumericRangeTree;

#define NumericRangeNode_IsLeaf(n) (n->left == NULL && n->right == NULL)

struct indexIterator *NewNumericRangeIterator(const RedisSearchCtx *sctx, NumericRange *nr,
                                              const NumericFilter *f, int skipMulti,
                                              const FieldFilterContext* filterCtx);

struct indexIterator *NewNumericFilterIterator(const RedisSearchCtx *ctx, const NumericFilter *flt,
                                               ConcurrentSearchCtx *csx, FieldType forType,
                                               IteratorsConfig *config, const FieldFilterContext* filterCtx);

/* Add an entry to a numeric range node. Returns the cardinality of the range after the
 * inserstion.
 * No deduplication is done */
size_t NumericRange_Add(NumericRange *r, t_docId docId, double value, int checkCard);

/* Create a new range node with the given capacity, minimum and maximum values */
NumericRangeNode *NewLeafNode(size_t cap, size_t splitCard);

/* Recursively find all the leaves under a node that correspond to a given min-max range. Returns a
 * vector with range node pointers.  */
Vector *NumericRangeNode_FindRange(NumericRangeNode *n, const NumericFilter *nf);

/* Recursively free a node and its children
 * rv will be updated with the number of cleaned up records and ranges in the subtree */
void NumericRangeNode_Free(NumericRangeNode *n, NRN_AddRv *rv);

/* Recursively trim empty nodes from tree  */
NRN_AddRv NumericRangeTree_TrimEmptyLeaves(NumericRangeTree *t);

/* Create a new tree */
NumericRangeTree *NewNumericRangeTree();

/* Add a value to a tree. Returns 0 if no nodes were split, 1 if we splitted nodes */
NRN_AddRv NumericRangeTree_Add(NumericRangeTree *t, t_docId docId, double value, int isMulti);

/* Remove a node containing a range with value.
   Returns 1 if node was found, 0 otherwise */
int NumericRangeTree_DeleteNode(NumericRangeTree *t, double value);

/* Recursively find all the leaves under tree's root, that correspond to a given min-max range.
 * Returns a vector with range node pointers. */
Vector *NumericRangeTree_Find(NumericRangeTree *t, const NumericFilter *nf);

/* Free the tree and all nodes */
void NumericRangeTree_Free(NumericRangeTree *t);

extern RedisModuleType *NumericIndexType;

NumericRangeTree *openNumericKeysDict(IndexSpec* spec, RedisModuleString *keyName, bool create_if_missing);

int NumericIndexType_Register(RedisModuleCtx *ctx);
void *NumericIndexType_RdbLoad(RedisModuleIO *rdb, int encver);
void NumericIndexType_RdbSave(RedisModuleIO *rdb, void *value);
void NumericIndexType_Digest(RedisModuleDigest *digest, void *value);
void NumericIndexType_Free(void *value);

NumericRangeTreeIterator *NumericRangeTreeIterator_New(NumericRangeTree *t);
NumericRangeNode *NumericRangeTreeIterator_Next(NumericRangeTreeIterator *iter);
void NumericRangeTreeIterator_Free(NumericRangeTreeIterator *iter);

#ifdef _DEBUG
static inline void PRINT_INDENT(int indent) {
  for (int i = 0; i < indent; ++i)
    printf("  ");
}

void NumericRangeNode_Dump(NumericRangeNode *n, int indent);
void NumericRange_Dump(NumericRange *r, int indent);
#endif // #ifdef _DEBUG

#ifdef __cplusplus
}
#endif
#endif
