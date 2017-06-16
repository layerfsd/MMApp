//
//  RSA.h
//  CPSAPP
//
//  Created by GPP on 15/7/8.
//  Copyright (c) 2015年 China M-world Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSA : NSObject {
    SecKeyRef publicKey;
    SecCertificateRef certificate;
    SecPolicyRef policy;
    SecTrustRef trust;
    size_t maxPlainLen;
}
- (NSData *) encryptWithData:(NSData *)content;
- (NSData *) encryptWithString:(NSString *)content;
- (NSString *) encryptToString:(NSString *)content;

+(instancetype)defaultRSA;

@end