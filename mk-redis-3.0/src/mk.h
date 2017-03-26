#include <stdio.h>
#ifndef MK_H
#define MK_H
#include "zmalloc.h"
#include <time.h>

#define MK_NORMAL       7
#define MK_EMPTY        8
#define MK_UPDATE       9

#define MK_NORMAL_UW    0
#define MK_NORMAL_W     1
#define MK_UPDATE_UW    2
#define MK_EMPTY_UW     3
#define MK_EMPTY_W      4
#define MK_MAX          5

#define OP_DEL          0
#define OP_UPDATE       1
#define OP_W2D          2

#define OP_MAX          3
#define MK_ACCESS_BUSY  0
#define MK_ACCESS_FREE  1

struct MonkeyKing{
    void *now;
    void *bkp;
    unsigned char state;
    unsigned char access;
    unsigned char writed;
    unsigned char *cur;
    void *(*dup)(const void *ptr);
    void (*free)(void *ptr);
};
void mkNormalW_Assert(struct MonkeyKing *mk);
void mkInit( struct MonkeyKing *mk,void *(*dup)(const void *ptr),
             void (*free)(void *ptr),unsigned char *cur);
void mkFreeNow(struct MonkeyKing *mk);
void mkFreeBkp(struct MonkeyKing *mk);
void mkSetNow(struct MonkeyKing *mk,void *val);
void mkSetBkp(struct MonkeyKing *mk,void *val);
void *mkGetNow(struct MonkeyKing *mk);
void *mkGetBkp(struct MonkeyKing *mk);
void mkStateFunctionMatrixInit(void);
int mkStateConvert(struct MonkeyKing *mk,unsigned char operation,void *val,unsigned char lock);
void mkHold(struct MonkeyKing *mk);
void mkRelease(struct MonkeyKing *mk);
#endif // MK_H
