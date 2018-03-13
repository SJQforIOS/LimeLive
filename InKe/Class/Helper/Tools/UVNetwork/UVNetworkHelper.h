//
//  UVNetworkHelper.h
//  UVoice
//
//  Created by wxj on 16/7/27.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability.h>

typedef NS_ENUM(NSInteger, HMNetWorkType)
{
    HMNetWorkUnknowType,    // 未知
    HMNetWorkEthernetType,  // Ethernet
    HMNetWorkWifiType ,     // WIFI
    HMNetWorkCellularType,  // 蜂窝网络,未知代
    HMNetWork2GType,        // 2G
    HMNetWork3GType,        // 3G
    HMNetWork4GType         // 4G
};

/**
 * 网络助手
 */
@interface UVNetworkHelper : NSObject

/**
 * 获取全局的Reachability
 */
+ (Reachability *)shareReachability;
+ (BOOL)isWifi;
+ (BOOL)isWWAN;

@end

@interface UVNetWorkListener : NSObject

+ (instancetype)shareInstance;
- (void)setup;

@end

@interface UVNetWorkInfoHelper : NSObject

+ (instancetype)shareInstance;
// 内网获取ip地址
- (NSString *)getIpAddresses;
// 运行商代码
-(NSString *)getcarrierCode;
//网络类型
- (HMNetWorkType )getNetWorkType;

@end
