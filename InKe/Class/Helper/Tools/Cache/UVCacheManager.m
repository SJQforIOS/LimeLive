//
//  UVCacheManager.m
//  UVoice
//
//  Created by wxj on 16/8/6.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import "UVCacheManager.h"
#import "NSString+HMCategory.h"
#import <YYCache.h>

@interface UVCacheKey ()

@property (nonnull, nonatomic, strong) NSString *domain;
@property (nonnull, nonatomic, strong) NSString *itemId;
@property (nonnull, nonatomic, readonly) NSString *key;

@end

@interface UVCacheManager ()

@property (nonatomic, strong) YYCache *cache;

@end

@implementation UVCacheManager

#pragma mark -

+ (instancetype)shareInstance
{
    static UVCacheManager *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [UVCacheManager new];
    });
    return __instance;
}

- (id)init
{
    if (self = [super init]) {
        self.cache = [[YYCache alloc] initWithName:@"HMCache"];
#if 0
        self.cache.diskCache.customArchiveBlock = ^NSData *(id object){
            return nil;
        };
        self.cache.diskCache.customUnarchiveBlock = ^id (NSData *data){
            return nil;
        };
#endif
    }
    return self;
}

- (nullable id)initWithCache:(nullable YYCache *)cache
{
    if (self = [super init]) {
        self.cache = cache;
    }
    return self;
}

#pragma mark -

- (void)setObject:(nullable id<NSCoding>)object forKey:(nonnull UVCacheKey *)key
{
    [self.cache setObject:object forKey:key.key];
}

- (void)setObject:(nullable id<NSCoding>)object forKey:(nonnull UVCacheKey *)key withBlock:(nullable void(^)(void))block
{
    [self.cache setObject:object forKey:key.key withBlock:^{
        NSLog(@"save cache finish for key:%@", key);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) block();
        });
    }];
}

- (void)objectForKey:(nonnull UVCacheKey *)key withBlock:(nullable void(^)(id<NSCoding> __nullable object))block
{
    [self.cache objectForKey:key.key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        NSLog(@"load cache finish for key:%@", key);
        dispatch_async(dispatch_get_main_queue(), ^{
           if (block) block(object);
        });
    }];
}

- (id<NSCoding> __nullable)objectForKey:(nonnull UVCacheKey *)key
{
    return [self.cache objectForKey:key.key];
}

- (void)removeObjectForKey:(nonnull UVCacheKey *)key withBlock:(nullable void(^)())block
{
    [self.cache removeObjectForKey:key.key withBlock:^(NSString * _Nonnull key) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) block();
        });
    }];
}

- (void)removeObjectForKey:(nonnull UVCacheKey *)key
{
    [self.cache removeObjectForKey:key.key];
}

- (void)clearAllCache
{
    [self.cache removeAllObjects];
}

@end

@implementation UVCacheKey

@synthesize key = _key;

+ (nonnull instancetype)cacheKeyWithDomain:(nonnull NSString *)domain itemId:(nonnull NSString *)itemId
{
    UVCacheKey *cacheKey = [UVCacheKey new];
    cacheKey.domain = domain;
    cacheKey.itemId = itemId;
    return cacheKey;
}

- (NSString *)key
{
    @synchronized (self) {
        if (!_key) {
            _key = [[self.domain stringByAppendingPathComponent:self.itemId] hm_md5Encrypt];
        }
        return _key;
    }
}

- (NSString *)description
{
    return [self.domain stringByAppendingFormat:@"_%@", self.itemId ? : @""];
}

@end
