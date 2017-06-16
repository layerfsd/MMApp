//
//  HCoreComm.h
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>


//单利宏
#undef AS_SINGLETON
#define AS_SINGLETON(__CLASS) \
+(__CLASS *) getInstance;\
-(__CLASS *) getInstance;

#undef DEF_SINGLETON
#define DEF_SINGLETON(__CLASS)\
+(__CLASS *) getInstance{\
static __CLASS * _singleton;\
static dispatch_once_t token;\
dispatch_once(&token, ^{\
_singleton = [[[self class]alloc] init];\
});\
return _singleton;\
}\
-(__CLASS *) getInstance{\
return [__CLASS getInstance];\
}



// 安全调用Block的方法
#undef	BLOCK_SAFE
#define BLOCK_SAFE(block)           if(block)block

//

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height
#define SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH   (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


// 判断是否是iOS7
#define IS_IOS7_Above ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
//判断当前是否是iOS8
#define IS_IOS8_Above ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 8)

#define IS_IOS9_Above ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 9)

#define IS_IOS10_Above ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 10)



#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#endif

