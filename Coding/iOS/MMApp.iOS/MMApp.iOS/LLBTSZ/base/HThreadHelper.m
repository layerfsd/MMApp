//
//  HThreadHelper.m
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 LLBT. All rights reserved.
//

#import "HThreadHelper.h"

@interface HThreadHelper(){

//主线程
dispatch_queue_t mainThreadPool;
//非主线程
dispatch_queue_t otherThreadPool;
}

@end

@implementation HThreadHelper
DEF_SINGLETON(HThreadHelper)


-(id) init{
    self=[super init];
    if(self){
        //串行队列
        mainThreadPool=dispatch_get_main_queue();
        //获取共享的并行队列
        otherThreadPool=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //创建的是串行队列
        // dispatch_queue_create("otherThread", nil);
    }
    return  self;
}

/**
 *  @name           H_getMainThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    获取主线程
 *  @return         dispatch_queue_t
 */
+(dispatch_queue_t)H_getMainThreadPool{
    return [[HThreadHelper getInstance]H_getMainThreadPool];
}


/**
 *  @name           H_getMainThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    获取主线程
 *  @return         dispatch_queue_t
 */
-(dispatch_queue_t)H_getMainThreadPool{
    return mainThreadPool;
}

/**
 *  @name           H_getOtherThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    获取非主线程
 *  @return         dispatch_queue_t
 */
+(dispatch_queue_t)H_getOtherThreadPool{
    return  [[HThreadHelper getInstance]H_getOtherThreadPool];
}

/**
 *  @name           H_getOtherThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    获取非主线程
 *  @return         dispatch_queue_t
 */
-(dispatch_queue_t)H_getOtherThreadPool{
    return  otherThreadPool;
}

/**
 *  @name           H_enqueueMainThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    主线程队列中添加线程
 *  @param          block 线程
 */
+(void)H_enqueueMainThreadPool:(dispatch_block_t) block{
    [[HThreadHelper getInstance]H_enqueueMainThreadPool:block];
}


/**
 *  @name           H_enqueueMainThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    主线程队列中添加线程
 *  @param          block 线程
 */
-(void)H_enqueueMainThreadPool:(dispatch_block_t) block{
    if (block) {
         dispatch_async(mainThreadPool, block);
    }
}


/**
 *  @name           H_enqueueOtherThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 */
+(void)H_enqueueOtherThreadPool:(dispatch_block_t) block{
    [[HThreadHelper getInstance]H_enqueueOtherThreadPool:block];
}


/**
 *  @name           H_enqueueOtherThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 */
-(void)H_enqueueOtherThreadPool:(dispatch_block_t) block{
    if (block) {
        dispatch_async(otherThreadPool, block);
    }
}


/**
 *  @name           H_enqueueMainThreadPoolWithDelay:delay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    主线程队列中添加线程
 *  @param          block 线程
 *  @param          s 延时(毫秒)
 */
+(void)H_enqueueMainThreadPoolWithDelay:(dispatch_block_t) block delay:(double) s{
    [[HThreadHelper getInstance]H_enqueueMainThreadPoolWithDelay:block delay:s];
}


/**
 *  @name           H_enqueueOtherThreadPoolWithDelay:delay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 */
+(void)H_enqueueOtherThreadPoolWithDelay:(dispatch_block_t) block delay:(double) s{
    [[HThreadHelper getInstance]H_enqueueOtherThreadPoolWithDelay:block delay:s];
}



/**
 *  @name           H_enqueueMainThreadPoolWithDelay:delay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    主线程队列中添加线程
 *  @param          block 线程
 */
-(void)H_enqueueMainThreadPoolWithDelay:(dispatch_block_t) block delay:(double) s{
    if (block) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, s * USEC_PER_SEC);
        dispatch_after( time, mainThreadPool, block );
    }
}


/**
 *  @name           H_enqueueOtherThreadPoolWithDelay:delay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 */
-(void)H_enqueueOtherThreadPoolWithDelay:(dispatch_block_t) block delay:(double) s{
    if (block) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, s * USEC_PER_SEC);
        dispatch_after( time, otherThreadPool, block );
    }
}


/**
 *  @name           H_barrierMainThreadPoolWithDelay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    主线程队列中添加线程
 *  @param          block 线程
 */
+(void)H_barrierMainThreadPoolWithDelay:(dispatch_block_t) block {
    [[HThreadHelper getInstance]H_barrierMainThreadPoolWithDelay:block];
}


/**
 *  @name           H_barrierOtherThreadPoolWithDelay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 */
+(void)H_barrierOtherThreadPoolWithDelay:(dispatch_block_t) block {
    [[HThreadHelper getInstance]H_barrierOtherThreadPoolWithDelay:block];
}


/**
 *  @name           H_barrierMainThreadPoolWithDelay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    主线程队列中添加线程
 *  @param          block 线程
  */
-(void)H_barrierMainThreadPoolWithDelay:(dispatch_block_t) block{
    if (block) {
        dispatch_barrier_async(mainThreadPool, block);
    }
}


/**
 *  @name           H_barrierOtherThreadPoolWithDelay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 */
-(void)H_barrierOtherThreadPoolWithDelay:(dispatch_block_t) block{
    if (block) {
        dispatch_barrier_async(otherThreadPool, block);
    }
}
/**
 *  @name           H_repeatThread
 *  @time           2016-02-17 10:06
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 *  @param          isMainThread 是否是主线程
 *  @param          repeatCount 重复执行次数
 */
+(void)H_repeatThread:(void (^)(size_t t)) block withMainThread:(BOOL)isMainThread withCount:(int)repeatCount{
    [self H_repeatThread:block withMainThread:isMainThread withCount:repeatCount];
}


/**
 *  @name           H_repeatThread
 *  @time           2016-02-17 10:06
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 *  @param          isMainThread 是否是主线程
 *  @param          repeatCount 重复执行次数
 */
-(void)H_repeatThread:(void (^)(size_t t)) block withMainThread:(BOOL)isMainThread withCount:(int)repeatCount{
    if (!block) {
        return;
    }
    if (isMainThread) {
        dispatch_apply(repeatCount, mainThreadPool, block);
    }else{
         dispatch_apply(repeatCount, otherThreadPool, block);
    }
}

@end
