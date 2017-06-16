//
//  HFileHelper.h
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HFileHelper : NSObject
/**
 *  @name           H_getHomeDir
 *  @time           2015-05-02 10:09
 *  @athor          goodluckus
 *  @description    获取应用程序住目录
 *  @return         NSString
 */
+(NSString *)H_getHomeDir;



/**
 *  @name           H_getDocumentsDir
 *  @time           2015-05-02 10:13
 *  @athor          goodluckus
 *  @description    获取应用程序documents目录
 *  @return         NSString
 */
+(NSString *)H_getDocumentsDir;


/**
 *  @name           H_getCachesDir
 *  @time           2015-05-02 10:16
 *  @athor          goodluckus
 *  @description    获取应用程序caches目录
 *  @return         NSString
 */
+(NSString *)H_getCachesDir;


/**
 *  @name           H_getTmpDir
 *  @time           2015-05-02 10:18
 *  @athor          goodluckus
 *  @description    获取应用程序临时文件目录
 *  @return         NSString
 */
+(NSString *)H_getTmpDir;


/**
 *  @name           H_getLibDir
 *  @time           2015-05-02 10:23
 *  @athor          goodluckus
 *  @description    获取应用程序LIB目录
 *  @return         NSString
 */
+(NSString *)H_getLibDir;

/**
 *  @name           H_createDir
 *  @time           2015-05-02 10:29
 *  @athor          goodluckus
 *  @description    创建文件夹
 *  @param          path 文件夹路径
 *  @return         是否创建成功
 */
+(BOOL)H_createDir:(NSString *)path;


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
+(bool)H_createFile:(NSString *)path content:(NSString *)content append:(BOOL) append;



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
+(bool)H_createFile:(NSString *)path contentData:(NSData *)contentData append:(BOOL) append;



/**
 *  @name           H_isFileExist:isDir
 *  @time           2015-05-02 11:22
 *  @athor          goodluckus
 *  @description    文件是否存在
 *  @param          path 文件夹路径
 *  @param          isDir 是否是文件夹
 *  @return         是否存在
 */
+(bool)H_isFileExist:(NSString *)path isDir:(BOOL *)isDir;


/**
 *  @name           H_readFileData
 *  @time           2015-05-02 11:30
 *  @athor          goodluckus
 *  @description    读取文件
 *  @param          path 文件夹路径
 *  @return         文件内容
 */
+(NSData *)H_readFileData:(NSString *) path;


/**
 *  @name           H_readFile
 *  @time           2015-05-02 11:30
 *  @athor          goodluckus
 *  @description    读取文件
 *  @param          path 文件夹路径
 *  @return         文件内容
 */
+(NSString *)H_readFile:(NSString *) path;



/**
 *  @name           H_deleteFile
 *  @time           2015-05-02 11:39
 *  @athor          goodluckus
 *  @description    删除文件
 *  @param          path 文件夹路径
 *  @return         操作是否成功
 */
+(BOOL)H_deleteFile:(NSString *)path;


/**
 *  @name           H_deleteFile
 *  @time           2015-05-02 11:39
 *  @athor          goodluckus
 *  @description    删除文件夹
 *  @param          path 文件夹路径
 *  @return         操作是否成功
 */
+(BOOL)H_deleteDir:(NSString *)path;


/**
 *  @name           H_copyFile:targetFilePath
 *  @time           2015-05-02 12:02
 *  @athor          goodluckus
 *  @description    复制文件
 *  @param          resFilePath 原文件夹路径
 *  @param          targetFilePath 目标文件路径
 *  @return         操作是否成功
 */
+(BOOL)H_copyFile:(NSString * )resFilePath targetFilePath:(NSString *) targetFilePath;


/**
 *  @name           H_copyDir:targetDirPath
 *  @time           2015-05-02 12:13
 *  @athor          goodluckus
 *  @description    复制文件夹
 *  @param          resDirPath 原文件夹路径
 *  @param          targetDirPath 目标文件路径
 *  @return         操作是否成功
 */
+(BOOL)H_copyDir:(NSString * )resDirPath targetDirPath:(NSString *) targetDirPath;

@end
