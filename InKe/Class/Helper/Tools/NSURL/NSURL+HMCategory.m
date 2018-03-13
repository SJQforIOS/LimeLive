//
//  NSURL+HMCategory.m
//  HMReader
//
//  Created by wxj on 16/7/28.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import "NSURL+HMCategory.h"
#import "NSString+HMCategory.h"

@implementation NSURL (HMCategory)

+ (NSURL *)hm_URLWithString:(NSString *)url
{
    if (!url.length) {
        return nil;
    }
    NSURL *n_url = [NSURL URLWithString:url];
    if (n_url) {
        return n_url;
    }
    return [NSURL URLWithString:[url hm_URLEcodedString]];
}

@end
