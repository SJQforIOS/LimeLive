//
//  NSString+HMCategory.m
//  HMReader
//
//  Created by wxj on 16/7/27.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import "NSString+HMCategory.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>
#import "NSURL+HMCategory.h"

@implementation NSString (HMEncryption)

- (NSString *)hm_md5Encrypt
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)hm_sha1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end

@implementation NSString (HMEncode)

- (NSString*)hm_URLDecodedString
{
    return [self stringByRemovingPercentEncoding];
}

- (NSString*)hm_URLEcodedString
{
    // TODO: 这个URL编码方式有问题
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (NSString *)hm_nameOfEncodingType:(NSStringEncoding)encoding
{
    CFStringEncoding cfEnc = CFStringConvertNSStringEncodingToEncoding(encoding);
    NSString *name = (NSString *)CFStringGetNameOfEncoding(cfEnc);
    return name;
}

@end

@implementation NSString (HMURL)

- (NSString *)hm_stringByAppendingURLComponent:(NSString *)str
{
    if (str.length == 0) return self;
    NSString *url = self;
    if (![url hasSuffix:@"/"]) {
        url = [url stringByAppendingString:@"/"];
    }
    NSRange range = [str rangeOfString:@"/"];
    if (range.location == 0) {
        str = [str substringWithRange:NSMakeRange(range.length, str.length - range.length)];
    }
    return [url stringByAppendingString:str];
}

static inline NSString * UVQueryStringFromParameters(NSDictionary *parameters) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [mutablePairs addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    return [mutablePairs componentsJoinedByString:@"&"];
}

static inline NSDictionary *UVQueryDictionaryFromString(NSString *queryString) {
    NSArray<NSString *> *keyvalueList = [queryString componentsSeparatedByString:@"&"];
    if (!keyvalueList.count) return nil;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:keyvalueList.count];
    [keyvalueList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<NSString *> *keyvalue = [obj componentsSeparatedByString:@"="];
        if (keyvalue.count != 2) return;
        [dict setObject:keyvalue.lastObject forKey:keyvalue.firstObject];
    }];
    return dict.copy;
}

- (NSString *)hm_urlStringByAppendURLQueryParameters:(NSDictionary *)parameters
{
    NSURL *URL = [NSURL hm_URLWithString:self];
    if (!parameters.count) return self;
    NSDictionary *queryDict = UVQueryDictionaryFromString(URL.query);
    NSMutableDictionary *tmpDict = parameters.mutableCopy;
    [tmpDict addEntriesFromDictionary:queryDict];
    NSURLComponents *URLComponents = [NSURLComponents componentsWithString:self];
    NSRange queryRange = NSMakeRange(0, 0);
    if (URLComponents.query.length) {
        queryRange = URLComponents.rangeOfQuery;
    }
    NSMutableString *newString = [NSMutableString stringWithString:self];
    if (queryRange.length == 0) {
        [newString appendFormat:@"?%@", UVQueryStringFromParameters(tmpDict)];
    } else {
        [newString replaceCharactersInRange:queryRange withString:UVQueryStringFromParameters(tmpDict)];
    }
    return newString.copy;
}

- (NSString *)hm_urlScheme
{
    return [NSURL hm_URLWithString:self].scheme;
}

@end

@implementation NSString (HMPath)

+ (NSString *)hm_pathExtensionForUrlString:(NSString *)urlString
{
    if (!urlString.length) return nil;
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:urlString];
    if (!urlComponents) return nil;
    return urlComponents.path.pathExtension;
}

- (NSString *)hm_relativeByHomeDirectoryPath
{
    NSRange range = [self rangeOfString:NSHomeDirectory()];
    if (!range.length) return nil;
    NSString *relativePath = [self stringByReplacingCharactersInRange:range withString:@""];
    if ([relativePath hasPrefix:@"/"]) {
        relativePath = [relativePath substringFromIndex:1];
    }
    return relativePath;
}

- (NSString *)hm_absolutePath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:self];
}

@end

@implementation NSString (HMVersion)

+ (NSComparisonResult)hm_compareFirstVersion:(NSString *)firstVersion secondVersion:(NSString *)secondVersion
{
    return [firstVersion compare:secondVersion options:NSNumericSearch];
}

- (NSComparisonResult)hm_compareWithVersion:(NSString *)version
{
    return [self compare:version options:NSNumericSearch];
}

- (BOOL)hm_isEqualToVersion:(NSString *)version
{
    return [self hm_compareWithVersion:version] == NSOrderedSame;
}

- (BOOL)hm_isHighToVersion:(NSString *)version
{
    return [self hm_compareWithVersion:version] == NSOrderedDescending;
}

- (BOOL)hm_isLowToVersion:(NSString *)version
{
    return [self hm_compareWithVersion:version] == NSOrderedAscending;
}

@end

@implementation NSString (HMCompare)

- (BOOL)hm_isEqualToStringCaseInsensitive:(NSString *)aString;
{
    return [self compare:aString options:NSCaseInsensitiveSearch] == 0;
}

@end

@implementation NSString (HMPrettify)

- (NSString *)hm_prettifyCalculatorResult
{
    NSString *result = self;
    NSRange dotRange = [result rangeOfString:@"."];
    if (dotRange.location < result.length && dotRange.length != 0) {
        NSArray <NSString *> *subResultList = [result componentsSeparatedByString:@"."];
        if (subResultList.count == 2) {
            NSString *decimalPart = subResultList[1];
            // 小数点后面全部是0，去除掉，只展示整形部分
            if ([decimalPart integerValue] == 0) {
                result = subResultList[0];
            } else {
                // 去除小数后面不需要的0
                NSInteger index = decimalPart.length - 1;
                while (index >= 0) {
                    unichar value = [decimalPart characterAtIndex:index];
                    if (value == '0') {
                        index --;
                    } else {
                        break;
                    }
                }
                if (index >= 0 && index < decimalPart.length) {
                    decimalPart = [decimalPart substringToIndex:index + 1];
                }
                result = subResultList[0];
                if (decimalPart) {
                    NSArray *valueList = @[subResultList[0], decimalPart];
                    result = [valueList componentsJoinedByString:@"."];
                }
            }
        }
    }
    return result;
}

@end

@implementation NSString (HMTime)

+ (NSString *)hm_formatePlaybackTime:(NSTimeInterval)time
{
    NSInteger i_time = time;
    if (i_time <= 60) {
        return [NSString stringWithFormat:@"%d:%02ld", 0, (long)i_time];
    } else if (i_time < 3600) {
        return [NSString stringWithFormat:@"%02ld:%02ld", i_time/60, i_time%60];
    } else {
        NSInteger hour = i_time/3600;
        NSTimeInterval lastTime = i_time - hour * 3600;
        if (hour < 100) {
            return [NSString stringWithFormat:@"%02ld:%02d:%02d", (long)hour, (int)lastTime/60, (int)lastTime%60];
        } else {
            return [NSString stringWithFormat:@"%ld:%02d:%02d", (long)hour, (int)lastTime/60, (int)lastTime%60];
        }
    }
}

@end

@implementation NSString (HMFilter)

- (NSString *)hm_filterEmoji
{
    __block NSMutableString* temp = [NSMutableString string];
    [self enumerateSubstringsInRange: NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
         BOOL returnValue = [substring hm_isEmoji];
         [temp appendString:!returnValue ? substring : @""];
     }];
#ifdef DEBUG
    if (![temp isEqualToString:self]) {
        NSLog(@"hm_filterEmoji 过滤的表情符号");
    }
#endif
    return temp.copy;
}

- (BOOL)hm_isEmoji
{
    NSArray *unRecognizedEmojiList = @[@"🤑", @"🤓", @"🤗", @"🤔", @"🤐", @"🤒", @"🤕", @"🤖", @"🤘", @"🤘🏻", @"🤘🏼", @"🤘🏽", @"🤘🏾", @"🤘🏿", @"🦁", @"🦄", @"🦂", @"🦀", @"🦃", @"🧀", @"‼️", @"⁉️"];
    BOOL returnValue = NO;
    const unichar hs = [self characterAtIndex:0];
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        } else {
            if (self.length > 1) {
                const unichar ls = [self characterAtIndex:self.length - 1];
                if (ls == 0x20e3) {
                    returnValue = YES;
                }
            }
        }
    }
    if (!returnValue) {
        returnValue = [unRecognizedEmojiList containsObject:self];
    }
    return returnValue;
}

@end

@implementation NSString (HMGUID)

+ (NSString *)hm_createGUID
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}

@end

@implementation NSString (HMAttributedString)

- (NSAttributedString *)hm_attributedStringWithLineSpace:(CGFloat)lineSpace
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = lineSpace;
    return [[NSAttributedString alloc] initWithString:self attributes:@{NSParagraphStyleAttributeName : style}];
}

@end

@implementation NSString (HMSerialization)

- (id)hm_jsonObject
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (!data.length) return nil;
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
