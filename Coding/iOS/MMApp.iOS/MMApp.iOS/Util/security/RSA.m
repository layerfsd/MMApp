//
//  RSA.m
//  CPSAPP
//
//  Created by GPP on 15/7/8.
//  Copyright (c) 2015年 China M-world Co.,Ltd. All rights reserved.
//

#import "RSA.h"
//#import "CPSConstant.h"
//#import "CPSLog.h"

static RSA *rsa = nil;
@implementation RSA
+(instancetype)defaultRSA{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rsa = [[RSA alloc] init];
    });
    return rsa;
}
- (id)init {
    self = [super init];
    
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    if (publicKeyPath == nil) {
        //CPSDebugLog(@"Can not find pub.der");
        return nil;
    }
    
    NSData *publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
    if (publicKeyFileContent == nil) {
        //CPSDebugLog(@"Can not read from pub.der");
        return nil;
    }
    
    certificate = SecCertificateCreateWithData(kCFAllocatorDefault, ( __bridge CFDataRef)publicKeyFileContent);
    if (certificate == nil) {
        //CPSDebugLog(@"Can not read certificate from pub.der");
        return nil;
    }
    
    policy = SecPolicyCreateBasicX509();
    OSStatus returnCode = SecTrustCreateWithCertificates(certificate, policy, &trust);
    if (returnCode != 0) {
        //CPSDebugLog(@"SecTrustCreateWithCertificates fail. Error Code: %d", (int)returnCode);
        return nil;
    }
    
    SecTrustResultType trustResultType;
    returnCode = SecTrustEvaluate(trust, &trustResultType);
    if (returnCode != 0) {
        return nil;
    }
    
    publicKey = SecTrustCopyPublicKey(trust);
    if (publicKey == nil) {
        //CPSDebugLog(@"SecTrustCopyPublicKey fail");
        return nil;
    }
    
    maxPlainLen = SecKeyGetBlockSize(publicKey) - 12;
    return self;
}

- (NSData *) encryptWithData:(NSData *)content {
    size_t plainLen = [content length];
    if (plainLen > maxPlainLen) {
        //CPSDebugLog(@"content(%ld) is too long, must < %ld", plainLen, maxPlainLen);
        return nil;
    }
    
    void *plain = malloc(plainLen);
    [content getBytes:plain
               length:plainLen];
    
    size_t cipherLen = 2048; // currently RSA key length is set to 2048 bytes
    void *cipher = malloc(cipherLen);
    
    OSStatus returnCode = SecKeyEncrypt(publicKey, kSecPaddingPKCS1, plain,
                                        plainLen, cipher, &cipherLen);
    
    NSData *result = nil;
    if (returnCode != 0) {
        //CPSDebugLog(@"SecKeyEncrypt fail. Error Code: %d", (int)returnCode);
    }
    else {
        result = [NSData dataWithBytes:cipher
                                length:cipherLen];
    }
    
    free(plain);
    free(cipher);
    
    return result;
}

- (NSData *) encryptWithString:(NSString *)content {
    return [self encryptWithData:[content dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *) encryptToString:(NSString *)content {
    NSData *data = [self encryptWithString:content];
    return [self base64forData:data];
}

// convert NSData to NSString
- (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (void)dealloc{
    CFRelease(certificate);
    CFRelease(trust);
    CFRelease(policy);
    CFRelease(publicKey);
}
@end
