//
//  HThreadHelper.h
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 LLBT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCoreComm.h"

@interface HThreadHelper : NSObject
AS_SINGLETON(HThreadHelper)



/**
*  @name           H_getMainThreadPool
*  @time           2015-05-02 13:41
*  @athor          goodluckus
*  @description    获取主线程
*  @return         dispatch_queue_t
*/
+(dispatch_queue_t)H_getMainThreadPool;


/**
 *  @name           H_getOtherThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    获取非主线程
 *  @return         dispatch_queue_t
 */
+(dispatch_queue_t)H_getOtherThreadPool;


/**
 *  @name           H_enqueueMainThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    主线程队列中添加线程
 *  @param          block 线程
 */
+(void)H_enqueueMainThreadPool:(dispatch_block_t) block;


/**
 *  @name           H_enqueueOtherThreadPool
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 */
+(void)H_enqueueOtherThreadPool:(dispatch_block_t) block;



/**
 *  @name           H_enqueueMainThreadPoolWithDelay:delay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    主线程队列中添加线程
 *  @param          block 线程
 *  @param          s 延时(毫秒)
 */
+(void)H_enqueueMainThreadPoolWithDelay:(dispatch_block_t) block delay:(double) s;


/**
 *  @name           H_enqueueOtherThreadPoolWithDelay:delay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 *  @param          s 延时(毫秒)
 */
+(void)H_enqueueOtherThreadPoolWithDelay:(dispatch_block_t) block delay:(double) s;



/**
 *  @name           H_barrierMainThreadPoolWithDelay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    主线程队列中添加线程,会等待上一个线程执行完成后才回执行
 *  @param          block 线程
 */
+(void)H_barrierMainThreadPoolWithDelay:(dispatch_block_t) block;


/**
 *  @name           H_barrierOtherThreadPoolWithDelay
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程,会等待上一个线程执行完成后才回执行
 *  @param          block 线程
 */
+(void)H_barrierOtherThreadPoolWithDelay:(dispatch_block_t) block;


/**
 *  @name           H_repeatThread
 *  @time           2016-02-17 10:06
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 *  @param          isMainThread 是否是主线程
 *  @param          repeatCount 重复执行次数
 */
+(void)H_repeatThread:(void (^)(size_t t)) block withMainThread:(BOOL)isMainThread withCount:(int)repeatCount;


/**
 *  @name           repeatThread
 *  @time           2016-02-17 10:06
 *  @athor          goodluckus
 *  @description    非主线程队列中添加线程
 *  @param          block 线程
 *  @param          isMainThread 是否是主线程
 *  @param          repeatCount 重复执行次数
 */
-(void)H_repeatThread:(void (^)(size_t t) ) block withMainThread:(BOOL)isMainThread withCount:(int)repeatCount;


@end
