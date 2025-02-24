/*
 * Copyright Redis Ltd. 2016 - present
 * Licensed under your choice of the Redis Source Available License 2.0 (RSALv2) or
 * the Server Side Public License v1 (SSPLv1).
 */

#define MR_CHAN_C_
#include <pthread.h>
#include <sys/time.h>
#include <stdlib.h>
#include <errno.h>
#include <stdio.h>
#include <assert.h>

void *MRCHANNEL_CLOSED = (void *)"MRCHANNEL_CLOSED";

typedef struct chanItem {
  void *ptr;
  struct chanItem *next;
} chanItem;

typedef struct MRChannel {
  chanItem *head;
  chanItem *tail;
  size_t size;
  volatile int open;
  pthread_mutex_t lock;
  pthread_cond_t cond;
  // condition used to wait for closing
  pthread_cond_t closeCond;
} MRChannel;

#include "chan.h"
#include "rmalloc.h"

MRChannel *MR_NewChannel() {
  MRChannel *chan = rm_malloc(sizeof(*chan));
  *chan = (MRChannel){
      .head = NULL,
      .tail = NULL,
      .size = 0,
      .open = 1,
  };
  pthread_cond_init(&chan->cond, NULL);
  pthread_cond_init(&chan->closeCond, NULL);

  pthread_mutex_init(&chan->lock, NULL);
  return chan;
}

/* Safely wait until the channel is closed */
void MRChannel_WaitClose(MRChannel *chan) {
  pthread_mutex_lock(&chan->lock);
  while (chan->open) {
    pthread_cond_wait(&chan->closeCond, &chan->lock);
  }
  pthread_mutex_unlock(&chan->lock);
}

void MRChannel_Free(MRChannel *chan) {

  // TODO: proper drain and stop routine

  pthread_mutex_destroy(&chan->lock);
  pthread_cond_destroy(&chan->cond);
  rm_free(chan);
}

size_t MRChannel_Size(MRChannel *chan) {
  pthread_mutex_lock(&chan->lock);
  size_t ret = chan->size;
  pthread_mutex_unlock(&chan->lock);
  return ret;
}

PushErrorMask MRChannel_Push(MRChannel *chan, void *ptr) {

  pthread_mutex_lock(&chan->lock);
  int rc = 0;
  if (!chan->open) {
    rc = CHANNEL_CLOSED;
    goto end;
  }

  chanItem *item = rm_malloc(sizeof(*item));
  item->next = NULL;
  item->ptr = ptr;
  if (chan->tail) {
    // make it the next of the current tail
    chan->tail->next = item;
    // set a new tail
    chan->tail = item;
  } else {  // no tail means no head - empty queue
    chan->head = chan->tail = item;
  }
  chan->size++;
end:
  if (pthread_cond_broadcast(&chan->cond)) rc |= BROADCAST_FAILURE;
  pthread_mutex_unlock(&chan->lock);
  return rc;
}

void *MRChannel_UnsafeForcePop(MRChannel *chan) {
  chanItem *item = chan->head;
  if (!item) {
    return NULL;
  }
  chan->head = item->next;
  // empty queue...
  if (!chan->head) chan->tail = NULL;
  chan->size--;
  // discard the item (TODO: recycle items)
  void* ret = item->ptr;
  rm_free(item);
  return ret;
}

// todo wait is not actually used anywhere...
void *MRChannel_Pop(MRChannel *chan) {
  void *ret = NULL;

  pthread_mutex_lock(&chan->lock);
  while (!chan->size) {
    if (!chan->open) {
      pthread_mutex_unlock(&chan->lock);
      return MRCHANNEL_CLOSED;
    }

    int rc = pthread_cond_wait(&chan->cond, &chan->lock);
    assert(rc == 0 && "cond_wait failed");
  }

  chanItem *item = chan->head;
  assert(item);
  chan->head = item->next;
  // empty queue...
  if (!chan->head) chan->tail = NULL;
  chan->size--;
  pthread_mutex_unlock(&chan->lock);
  // discard the item (TODO: recycle items)
  ret = item->ptr;
  rm_free(item);
  return ret;
}

void MRChannel_Close(MRChannel *chan) {
  pthread_mutex_lock(&chan->lock);
  chan->open = 0;
  // notify any waiting readers
  pthread_cond_broadcast(&chan->cond);
  pthread_cond_broadcast(&chan->closeCond);

  pthread_mutex_unlock(&chan->lock);
}
