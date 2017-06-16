//
//  HFileHelper.m
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import "HFileHelper.h"

@implementation HFileHelper

/**
 *  @name           H_getHomeDir
 *  @time           2015-05-02 10:09
 *  @athor          goodluckus
 *  @description    获取应用程序住目录
 *  @return         NSString
 */
+(NSString *)H_getHomeDir{
    return NSHomeDirectory();
}


/**
 *  @name           H_getDocumentsDir
 *  @time           2015-05-02 10:13
 *  @athor          goodluckus
 *  @description    获取应用程序documents目录
 *  @return         NSString
 */
+(NSString *)H_getDocumentsDir{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return  [paths objectAtIndex:0];
}


/**
 *  @name           H_getCachesDir
 *  @time           2015-05-02 10:16
 *  @athor          goodluckus
 *  @description    获取应用程序caches目录
 *  @return         NSString
 */
+(NSString *)H_getCachesDir{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}


/**
 *  @name           H_getTmpDir
 *  @time           2015-05-02 10:18
 *  @athor          goodluckus
 *  @description    获取应用程序临时文件目录
 *  @return         NSString
 */
+(NSString *)H_getTmpDir{
    return NSTemporaryDirectory();
}


/**
 *  @name           H_getLibDir
 *  @time           2015-05-02 10:23
 *  @athor          goodluckus
 *  @description    获取应用程序LIB目录
 *  @return         NSString
 */
+(NSString *)H_getLibDir{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}


/**
 *  @name           H_createDir
 *  @time           2015-05-02 10:29
 *  @athor          goodluckus
 *  @description    创建文件夹
 *  @param          path 文件夹路径
 *  @return         NSString
 */
+(BOOL)H_createDir:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir){
        return YES;
    }
    return  [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}


/**
 *  @name           H_createFile:content:append
 *  @time           2015-05-02 10:34
 *  @athor          goodluckus
 *  @description    创建文件
 *  @param          path 文件夹路径
 *  @param          content 文件内容
 *  @param          append  是否以追加方式创建文件
 *  @return         是否创建成功
 */
+(bool) H_createFile:(NSString *)path content:(NSString *)content append:(BOOL) append{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path isDirectory:0]){
        if(append){
            NSFileHandle *writer=[NSFileHandle fileHandleForWritingAtPath:path];
            [writer seekToEndOfFile];
            [writer writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
            [writer closeFile];
            return true;
        }else{
            return[fileManager removeItemAtPath:path error:nil] && [fileManager createFileAtPath:path contents:[content dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        }
    }else{
        return [fileManager createFileAtPath:path contents:[content dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    }
}


/**
 *  @name           H_createFile:contentData:append
 *  @time           2015-05-02 10:48
 *  @athor          goodluckus
 *  @description    创建文件
 *  @param          path 文件夹路径
 *  @param          contentData 文件内容
 *  @param          append  是否以追加方式创建文件
 *  @return         是否创建成功
 */
+(bool) H_createFile:(NSString *)path contentData:(NSData *)contentData append:(BOOL) append{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path isDirectory:0]){
        if(append){
            NSFileHandle *writer=[NSFileHandle fileHandleForWritingAtPath:path];
            [writer seekToEndOfFile];
            [writer writeData:contentData];
            [writer closeFile];
            return true;
            
        }else{
            return[fileManager removeItemAtPath:path error:nil] && [fileManager createFileAtPath:path contents:contentData attributes:nil];
        }
    }else{
        return [fileManager createFileAtPath:path contents:contentData attributes:nil];
    }
}


/**
 *  @name           H_isFileExist:isDir
 *  @time           2015-05-02 11:22
 *  @athor          goodluckus
 *  @description    文件是否存在
 *  @param          path 文件夹路径
 *  @param          isDir 是否是文件夹
 *  @return         是否存在
 */
+(bool) H_isFileExist:(NSString *)path isDir:(BOOL *)isDir{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path isDirectory:isDir];
}


/**
 *  @name           H_readFileData
 *  @time           2015-05-02 11:30
 *  @athor          goodluckus
 *  @description    读取文件
 *  @param          path 文件夹路径
 *  @return         文件内容
 */
+(NSData *)H_readFileData:(NSString *) path{
    return [NSData dataWithContentsOfFile:path];
}


/**
 *  @name           H_readFile
 *  @time           2015-05-02 11:30
 *  @athor          goodluckus
 *  @description    读取文件
 *  @param          path 文件夹路径
 *  @return         文件内容
 */
+(NSString *)H_readFile:(NSString *) path{
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}


/**
 *  @name           H_deleteFile
 *  @time           2015-05-02 11:39
 *  @athor          goodluckus
 *  @description    删除文件
 *  @param          path 文件夹路径
 *  @return         操作是否成功
 */
+(BOOL) H_deleteFile:(NSString *)path{
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}


/**
 *  @name           H_deleteFile
 *  @time           2015-05-02 11:39
 *  @athor          goodluckus
 *  @description    删除文件夹
 *  @param          path 文件夹路径
 *  @return         操作是否成功
 */
+(BOOL) H_deleteDir:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:path error:nil];
}


/**
 *  @name           H_copyFile:targetFilePath
 *  @time           2015-05-02 12:02
 *  @athor          goodluckus
 *  @description    复制文件
 *  @param          resFilePath 原文件夹路径
 *  @param          targetFilePath 目标文件路径
 *  @return         操作是否成功
 */
+(BOOL) H_copyFile:(NSString * )resFilePath targetFilePath:(NSString *) targetFilePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager copyItemAtPath:resFilePath toPath:targetFilePath error:nil];
    //    NSString *cmd=  @"cp -pf ";s
    //    cmd= [cmd stringByAppendingString:resFilePath];
    //    cmd= [cmd stringByAppendingString:@"  "];
    //    cmd= [cmd stringByAppendingString:targetFilePath];
    //    return system([cmd cStringUsingEncoding:NSUTF8StringEncoding])==0;
}

/**
 *  @name           H_copyDir:targetDirPath
 *  @time           2015-05-02 12:13
 *  @athor          goodluckus
 *  @description    复制文件夹
 *  @param          resDirPath 原文件夹路径
 *  @param          targetDirPath 目标文件路径
 *  @return         操作是否成功
 */
+(BOOL) H_copyDir:(NSString * )resDirPath targetDirPath:(NSString *) targetDirPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager copyItemAtPath:resDirPath toPath:targetDirPath error:nil];
    //    NSString *cmd=  @"cp -rf ";
    //    cmd= [cmd stringByAppendingString:resDirPath];
    //    cmd= [cmd stringByAppendingString:@"  "];
    //    cmd= [cmd stringByAppendingString:targetDirPath];
    //    return system([cmd cStringUsingEncoding:NSUTF8StringEncoding])==0;
}

@end
