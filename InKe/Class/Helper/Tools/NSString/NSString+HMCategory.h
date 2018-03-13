//
//  NSString+HMCategory.h
//  HMReader
//
//  Created by wxj on 16/7/27.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (HMEncryption)

- (NSString *)hm_md5Encrypt;
- (NSString *)hm_sha1;

@end

@interface NSString (HMEncode)

- (NSString*)hm_URLDecodedString;
- (NSString*)hm_URLEcodedString;

/**
 * Note: 部分情况下获取到的编码名称为空
 */
+ (NSString *)hm_nameOfEncodingType:(NSStringEncoding)encoding;

@end

@interface NSString (HMURL)

- (NSString *)hm_stringByAppendingURLComponent:(NSString *)str;
- (NSString *)hm_urlStringByAppendURLQueryParameters:(NSDictionary *)parameters;
- (NSString *)hm_urlScheme;

@end

@interface NSString (HMPath)

+ (NSString *)hm_pathExtensionForUrlString:(NSString *)urlString;

/**
 * 相对于应用程序沙盒的相对路径
 */
- (NSString *)hm_relativeByHomeDirectoryPath;

/**
 * 获取绝对路径， 与hm_relativeByHomeDirectoryPath相对应
 */
- (NSString *)hm_absolutePath;

@end

@interface NSString (HMVersion)

/*
 * @Desc:
 *       比较两个版本号的大小
 */
+ (NSComparisonResult)hm_compareFirstVersion:(NSString *)firstVersion secondVersion:(NSString *)secondVersion;

/*
 * @Desc:
 *       比较版本号的大小，字符串的形式需要时x.x.x... (x为数字)
 */
- (NSComparisonResult)hm_compareWithVersion:(NSString *)version;

/*
 * @Desc:
 *       比较版本号是否相同
 */
- (BOOL)hm_isEqualToVersion:(NSString *)version;

/*
 * @Desc:
 *       是否比version版本号高
 */
- (BOOL)hm_isHighToVersion:(NSString *)version;

/*
 * @Desc:
 *       是否比version版本号低
 */
- (BOOL)hm_isLowToVersion:(NSString *)version;

@end

@interface NSString (HMCompare)

- (BOOL)hm_isEqualToStringCaseInsensitive:(NSString *)aString;

@end

@interface NSString (HMPrettify)

- (NSString *)hm_prettifyCalculatorResult;

@end

@interface NSString (HMTime)

+ (NSString *)hm_formatePlaybackTime:(NSTimeInterval)time;

@end

@interface NSString (HMFilter)

- (NSString *)hm_filterEmoji;

@end

@interface NSString (HMGUID)

+ (NSString *)hm_createGUID;

@end

@interface NSString (HMAttributedString)

- (NSAttributedString *)hm_attributedStringWithLineSpace:(CGFloat)lineSpace;

@end

@interface NSString (HMSerialization)

- (id)hm_jsonObject;

@end
