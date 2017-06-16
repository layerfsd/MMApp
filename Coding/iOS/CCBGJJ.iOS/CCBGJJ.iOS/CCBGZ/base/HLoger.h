//
//  HLoger.h
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCoreComm.h"
//日志等级
typedef enum{
    L_NONE=0,
    L_INFO=1,
    L_WARN=2,
    L_DEBUG=4,
    L_ERROR=8,
    L_ALL=15,
} LOGGER_LEVEL;


#undef	HERROR
#define HERROR( ... )	[[HLoger getInstance] H_level:L_ERROR format:__VA_ARGS__];

#undef	HDEBUG
#define HDEBUG( ... )	[[HLoger getInstance] H_level:L_DEBUG format:__VA_ARGS__];

#undef	HWARN
#define HWARN( ...  )	[[HLoger getInstance] H_level:L_WARN format:__VA_ARGS__];

#undef	HINFO
#define HINFO( ...  )	[[HLoger getInstance] H_level:L_INFO format:__VA_ARGS__];

@interface HLoger : NSObject

AS_SINGLETON(HLoger)



/**
 *  @name           H_setIsLogFile:loggerPath
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    设置是否将日志输出到文件
 *  @param          isOutLoggerFile 是否输出日志
 */
-(void)H_setIsLogFile:(BOOL) isOutLoggerFile loggerPath:(NSString *)loggerPath;


/**
 *  @name           H_setLogLevel
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    设置日志等级
 *  @param          level 日志等级
 */
-(void) H_setLogLevel:(LOGGER_LEVEL) level;



/**
 *  @name           H_level:format
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    打印日志
 *  @param          level 日志等级
 *  @param          format 格式化
 */
- (void)H_level:(LOGGER_LEVEL)level format:(NSString *)format, ...;

/**
 *  @name           H_level:format
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    打印日志
 *  @param          level 日志等级
 *  @param          format 格式化
 */
- (void)H_level:(LOGGER_LEVEL)level format:(NSString *)format args:(va_list)args;

@end
