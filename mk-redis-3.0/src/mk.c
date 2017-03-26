#include "mk.h"
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
void (*StateConvertMatrix[MK_MAX][OP_MAX])(struct MonkeyKing *,void *);
void (*mkAssertMatrix[MK_MAX])(struct MonkeyKing *mk);
void mkInit( struct MonkeyKing *mk,void *(*dup)(const void *ptr),
             void (*free)(void *ptr),unsigned char *cur)
{
    mk->dup = dup;
    mk->free = free;
    mk->access = MK_ACCESS_FREE;
    mk->bkp = NULL;
    mk->now = NULL;
    mk->state = MK_NORMAL;
    mk->cur = cur;
    mk->writed = *(mk->cur);
}
void mkFreeNow(struct MonkeyKing *mk)
{
    if (mk->free)
        mk->free(mk->now);
    mk->now = NULL;
}
void mkFreeBkp(struct MonkeyKing *mk)
{
    if (mk->free)
        mk->free(mk->bkp);
    mk->now = NULL;
}
void mkSetNow(struct MonkeyKing *mk,void *val)
{
    if (mk->dup)
        mk->now = mk->dup(val);
    else
        mk->now = val;
}
void mkSetBkp(struct MonkeyKing *mk,void *val)
{
    if (mk->dup)
        mk->bkp = mk->dup(val);
    else
        mk->bkp = val;
}
void *mkGetNow(struct MonkeyKing *mk)
{
    return mk->now;
}
void mkNormalW_Assert(struct MonkeyKing *mk)
{
    assert(mk->state == MK_NORMAL);
    assert(mk->now != NULL);
    assert(mk->bkp == NULL);
    assert(mk->writed == *(mk->cur));
}
void mkNormalUW_Assert(struct MonkeyKing *mk)
{
    assert(mk->state == MK_NORMAL);
    assert(mk->now != NULL);
    assert(mk->bkp == NULL);
    assert(mk->writed != *(mk->cur));
}
void mkUpdateUW_Assert(struct MonkeyKing *mk)
{
    assert(mk->state == MK_UPDATE);
    assert(mk->now != NULL);
    assert(mk->bkp != NULL);
    assert(mk->writed != *(mk->cur));
}
void mkEmptyW_Assert(struct MonkeyKing *mk)
{
    assert(mk->state == MK_EMPTY);
    assert(mk->now == NULL);
    assert(mk->bkp == NULL);
    assert(mk->writed == *(mk->cur));
}
void mkEmptyUW_Assert(struct MonkeyKing *mk)
{
    assert(mk->state == MK_EMPTY);
    assert(mk->now == NULL);
    assert(mk->bkp != NULL);
    assert(mk->writed != *(mk->cur));
}
//normal_w
void mkNormalW_Update(struct MonkeyKing *mk,void *val)
{
    //NormalW-->Update-->NormalW
    assert( val != NULL);
    mkFreeNow(mk);
    mkSetNow(mk,val);
}
//normal_uw
void mkNormalUW_Update(struct MonkeyKing *mk,void *val)
{
    //NormalUW --> update --> Update_UW
    assert(val != NULL);
    mkFreeNow(mk);
    mkSetNow(mk,val);
}
void mkNormalUW_Del(struct MonkeyKing *mk,void *val)
{
    //NormalUW-->Del-->Empty_UW
    assert( val == NULL);
    mk->bkp = mk->now;
    mk->now = NULL;
    mk->state = MK_NORMAL;
}
void mkNormalUW_W2D(struct MonkeyKing *mk,void *val)
{
    //NormalUW-->W2D-->NormalW
    assert(NULL == val);
    mk->writed = *(mk->cur);
    mk->state = MK_NORMAL;
}
//empty_w
void mkEmptyW_Del(struct MonkeyKing *mk,void *val)
{
    //Empty_w --> del --> Empty_w

}
void mkEmptyW_Update(struct MonkeyKing *mk,void *val)
{
    //Empty_w --> update --> Normal_w
    assert(NULL != val);
    mkSetNow(mk,val);
    mk->state = MK_NORMAL;
}
//empty_uw
void mkEmptyUW_Del(struct MonkeyKing *mk,void *val)
{
    assert(NULL == val);
}
void mkEmptyUW_Update(struct MonkeyKing *mk,void *val)
{
    //EmptyUW --> update --> Update_UW
    assert( NULL != val);
    mkSetNow(mk,val);
    mk->state = MK_UPDATE;
}
void mkEmptyUW_W2D(struct MonkeyKing *mk,void *val)
{
    //EmptyUW --> update --> EmptyW
    assert(val == NULL);
    mkFreeBkp(mk);
    mk->state = MK_EMPTY;
    mk->writed = *(mk->cur);
}
//update_uw
void mkUPdateUW_Del(struct MonkeyKing *mk,void *val)
{
    //Update_uw --> del -->empty_uw
    assert( val == NULL);
    mkFreeNow(mk);
    mk->state = MK_EMPTY;
}
void mkUPdateUW_Update(struct MonkeyKing *mk,void *val)
{
    //Update_uw --> update --> update_uw
    assert( val != NULL);
    mkFreeNow(mk);
    mkSetNow(mk,val);
}
void mkUPdateUW_W2D(struct MonkeyKing *mk,void *val)
{
    //Update_uw --> w2d --> normal_w
    assert( val == NULL);
    mkFreeBkp(mk);
    mk->writed = *(mk->cur);
    mk->state = MK_NORMAL;
}
void mkStateFunctionMatrixInit( void)
{
    static unsigned char i = 1;

    if (i){
        i = 0;
        memset(StateConvertMatrix,0,sizeof(StateConvertMatrix));

        StateConvertMatrix[MK_NORMAL_UW][OP_DEL]    = mkNormalUW_Del;
        StateConvertMatrix[MK_NORMAL_UW][OP_UPDATE] = mkNormalUW_Update;
        StateConvertMatrix[MK_NORMAL_UW][OP_W2D]    = mkNormalUW_W2D;

        StateConvertMatrix[MK_NORMAL_W][OP_DEL]     = mkNormalUW_Del;
        StateConvertMatrix[MK_NORMAL_W][OP_UPDATE]  = mkNormalW_Update;

        StateConvertMatrix[MK_UPDATE_UW][OP_DEL]    = mkUPdateUW_Del;
        StateConvertMatrix[MK_UPDATE_UW][OP_W2D]    = mkUPdateUW_W2D;
        StateConvertMatrix[MK_UPDATE_UW][OP_UPDATE] = mkUPdateUW_Update;

        StateConvertMatrix[MK_EMPTY_UW][OP_DEL]     = mkEmptyUW_Del;
        StateConvertMatrix[MK_EMPTY_UW][OP_UPDATE]  = mkEmptyUW_Update;
        StateConvertMatrix[MK_EMPTY_UW][OP_W2D]     = mkEmptyUW_W2D;

        StateConvertMatrix[MK_EMPTY_W][OP_DEL]      = mkEmptyW_Del;
        StateConvertMatrix[MK_EMPTY_W][OP_UPDATE]   = mkEmptyW_Update;

        memset(mkAssertMatrix,0,sizeof(mkAssertMatrix));

        mkAssertMatrix[MK_EMPTY_UW]     = mkEmptyUW_Assert;
        mkAssertMatrix[MK_EMPTY_W]      = mkEmptyW_Assert;
        mkAssertMatrix[MK_NORMAL_UW]    = mkNormalUW_Assert;
        mkAssertMatrix[MK_NORMAL_W]     = mkNormalW_Assert;
        mkAssertMatrix[MK_UPDATE_UW]    = mkUpdateUW_Assert;
    }
}
void *mkGetBkp(struct MonkeyKing *mk)
{
    void *retval;
    mkHold(mk);
    if ( mk->bkp)
        retval = mk->bkp;
    else
        retval = mk->now;
    mkRelease(mk);
    return retval;
}
unsigned char getRealState(struct MonkeyKing *mk,unsigned char cur)
{
    switch (mk->state){

        case MK_EMPTY:
            if (mk->writed == cur)
                return MK_EMPTY_W;
            else
                return MK_EMPTY_UW;
            break;
        case MK_UPDATE:
                return MK_UPDATE_UW;
            break;
        case MK_NORMAL:
            if (mk->writed == cur)
                return MK_NORMAL_W;
            else
                return MK_NORMAL_UW;
            break;
        default:
            printf("getRealState error! state %d,cur %d,writed %d\n",(int)mk->state,(int)cur,(int)mk->writed);
            exit(1);
            return 255;
    }
}
void mkHold(struct MonkeyKing *mk)
{
    unsigned char expect_free = MK_ACCESS_FREE;
    while(!__atomic_compare_exchange_1(&mk->access,
                                      &expect_free,
                                      MK_ACCESS_BUSY,
                                      0, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)){
        usleep(10);
        expect_free = MK_ACCESS_FREE;
    }
}
void mkRelease(struct MonkeyKing *mk)
{
    __atomic_store_1(&mk->access,MK_ACCESS_FREE,__ATOMIC_SEQ_CST);
}
int mkStateConvert(struct MonkeyKing *mk,unsigned char operation,void *val,unsigned char lock)
{
    unsigned char state;
    state = getRealState(mk,*(mk->cur));
//    mkAssertMatrix[state](mk,cur);
    if (lock){
        mkHold(mk);
        StateConvertMatrix[state][operation](mk,val);
        mkRelease(mk);
    }
    else{
        StateConvertMatrix[state][operation](mk,val);
    }
//    state = getRealState(mk,cur);
//    mkAssertMatrix[state](mk,cur);
    return 1;
}
