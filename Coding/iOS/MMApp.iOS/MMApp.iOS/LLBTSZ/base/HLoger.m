//
//  HLoger.m
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 LLBT. All rights reserved.
//

#import "HLoger.h"
#import "HCoreComm.h"
#import "HThreadHelper.h"
#import "HFileHelper.h"
@interface HLoger(){
    //是否将日志输出到文件
    bool mIsoutLoggerFile;
    //日志等级
    LOGGER_LEVEL mLevel;
    //日志路径
    NSString *mLoggerPath;
}
@end


@implementation HLoger

DEF_SINGLETON(HLoger)


/**
 *  @name           init
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    init
 *  @return         LogHelper
 */
-(id) init{
    if(self = [super init])
    {
        mLevel=L_ALL;
        mIsoutLoggerFile=false;
        mLoggerPath=nil;
    }
    return self;
    
}


/**
 *  @name           H_setIsLogFile:loggerPath
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    设置是否将日志输出到文件
 *  @param          isOutLoggerFile 是否输出日志
 *  @param          loggerPaht 日志路径
 *  @return         void
 */
-(void)H_setIsLogFile:(BOOL) isOutLoggerFile loggerPath:(NSString *)loggerPath{
    mIsoutLoggerFile=isOutLoggerFile;
    mLoggerPath=loggerPath;
}

/**
 *  @name           setLogLevel
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    设置日志等级
 *  @param          level 日志等级
 *  @return         void
 */
-(void) H_setLogLevel:(LOGGER_LEVEL) level{
    mLevel=level;
}


/**
 *  @name           level:format
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    打印日志
 *  @param          level 日志等级
 *  @param          format 格式化
 *  @return         void
 */
- (void)H_level:(LOGGER_LEVEL)level format:(NSString *)format, ...{
    if ( nil == format || NO == [format isKindOfClass:[NSString class]] ){
        return;
    }
    va_list args;
    va_start( args, format );
    [self H_level:level format:format args:args];
    va_end( args );
}

/**
 *  @name           H_level:format
 *  @time           2015-05-02 13:41
 *  @athor          goodluckus
 *  @description    打印日志
 *  @param          level 日志等级
 *  @param          format 格式化
 *  @return         void
 */
- (void)H_level:(LOGGER_LEVEL)level format:(NSString *)format args:(va_list)args{
    if (mLevel==L_NONE || ((mLevel & level) !=level)) {
        return;
    }
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *fileName=[dateFormatter stringFromDate:date];
    NSMutableString *temp=[[NSMutableString alloc]initWithString:str];
    if ( L_INFO == level )
    {
        [temp appendString:@"[INFO]"];
    }
    else if ( L_DEBUG == level )
    {
        [temp appendString:@"[DEBUG]"];
    }
    else if ( L_WARN == level )
    {
        [temp appendString:@"[WARN]"];
    }
    else if ( L_ERROR == level )
    {
        [temp appendString:@"[ERROR]"];
    }
    
    NSString * content = [[NSString alloc] initWithFormat:(NSString *)format arguments:args] ;
    [temp appendString:content];
    [temp appendString:@"\n"];
    fprintf( stderr, [temp UTF8String], NULL );
    if(mIsoutLoggerFile){
        NSString *path=[[mLoggerPath stringByAppendingString:@"/"]stringByAppendingString:fileName];
        [HThreadHelper H_barrierOtherThreadPoolWithDelay:^(){
            [HFileHelper H_createFile:path content:temp append:YES];
        }];
        
    }
}


@end
