//
//  NSString+HExt.m
//  HCore
//
//  Created by hyc on 16/11/5.
//  Copyright © 2016年 LLBT. All rights reserved.
//

#import "NSString+HExt.h"
@implementation NSString(HExt)
//转换为拼音
- (NSString*)H_pinyin {
    if (self == nil || self.length == 0) {
        return @"";
    }
    NSMutableString *result = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformStripDiacritics,NO);
    return [result uppercaseString];
}

//去掉首尾空格
-(NSString *)H_trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//是否为空串
- (BOOL)H_isEmptyOrWhitespace {
    return self == nil || !([self length] > 0) || [[self H_trim] length] == 0;
}

//是否是邮箱
-(BOOL)H_isEmail{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}


//是否是数字
-(BOOL)H_isNumber{
    if([self H_isEmptyOrWhitespace]){
        return NO;
    }
    NSString *integerOrFloatPointRegEx = @"^[-+]?\\d+(\\.\\d+)?$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", integerOrFloatPointRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

//是否包含字符
-(BOOL)H_isContainString:(NSString *)string{
    return [self rangeOfString:string].location != NSNotFound;
}



//URL转码
- (NSString *)H_URLEncoding
{
    //    NSString * result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
    //                                                                                              (CFStringRef)self,
    //                                                                                              NULL,
    //                                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
    //                                                                                              kCFStringEncodingUTF8 ));
    //    return result;
    
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    long sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

//URL解码
- (NSString *)H_URLDecoding
{
    NSMutableString * string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


//获取中英文字符长度
-(long)H_getUTF8Length{
    return [self dataUsingEncoding:NSUTF8StringEncoding].length;
}

//参数转码
+ (NSString *)escapedURLString:(NSString *)string{
    static NSString * const kAFCharactersToBeEscaped = @":/&=+?!@#$[]<>{}'\",;|\\^`%";//~`!！@#$￥%^&*()（）-_+={[]}:;"“‘<,>.?/
    static NSString * const kAFCharactersToLeaveUnescaped = @"-_.!~*\()";
    
    CFStringRef StringRef = CFURLCreateStringByAddingPercentEscapes
    (
     kCFAllocatorDefault,
     (CFStringRef)string,
     (CFStringRef)kAFCharactersToLeaveUnescaped,
     (CFStringRef)kAFCharactersToBeEscaped,
     kCFStringEncodingUTF8
     );
    
    NSString *escapedString = (NSString *)CFBridgingRelease(StringRef);
    
    if (escapedString) {
        return escapedString;
    }
    
    return @"";
}

@end
