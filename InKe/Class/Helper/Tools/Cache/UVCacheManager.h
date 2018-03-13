//
//  UVCacheManager.h
//  UVoice
//
//  Created by wxj on 16/8/6.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYCache;

@interface UVCacheKey : NSObject

@property (nonnull, nonatomic, readonly) NSString *domain;
@property (nonnull, nonatomic, readonly) NSString *itemId;

+ (nonnull instancetype)cacheKeyWithDomain:(nonnull NSString *)domain itemId:(nonnull NSString *)itemId;

@end

@interface UVCacheManager : NSObject

#pragma mark -

+ (nonnull instancetype)shareInstance;
- (nullable id)initWithCache:(nullable YYCache *)cache;

#pragma mark -

- (void)setObject:(nullable id<NSCoding>)object forKey:(nonnull UVCacheKey *)key;
- (void)setObject:(nullable id<NSCoding>)object forKey:(nonnull UVCacheKey *)key withBlock:(nullable void(^)(void))block;
- (void)objectForKey:(nonnull UVCacheKey *)key withBlock:(nullable void(^)(id<NSCoding> __nullable object))block;
- (id<NSCoding> __nullable)objectForKey:(nonnull UVCacheKey *)key;
- (void)removeObjectForKey:(nonnull UVCacheKey *)key withBlock:(nullable void(^)())block;
- (void)removeObjectForKey:(nonnull UVCacheKey *)key;
- (void)clearAllCache;

@end
