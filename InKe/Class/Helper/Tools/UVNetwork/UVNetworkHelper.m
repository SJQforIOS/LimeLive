//
//  UVNetworkHelper.m
//  UVoice
//
//  Created by wxj on 16/7/27.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import "UVNetworkHelper.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <CoreTelephony/CTCarrier.h>


@implementation UVNetworkHelper

+ (Reachability *)shareReachability
{
    static Reachability *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [Reachability reachabilityForInternetConnection];
    });
    return __instance;
}

+ (void)load
{
    [[self shareReachability] startNotifier];
}

+ (BOOL)isWifi
{
    return [[self shareReachability] isReachableViaWiFi];
}

+ (BOOL)isWWAN {
    return [[self shareReachability] isReachableViaWWAN];
}
@end

@implementation UVNetWorkListener

+ (void)load
{
    [[self class] shareInstance];
}

+ (instancetype)shareInstance
{
    static UVNetWorkListener *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [UVNetWorkListener new];
    });
    return __instance;
}

- (void)onNetworkStatusChanged:(NSNotification *)notification
{
}

- (id)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserverForName:kReachabilityChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            [self onNetworkStatusChanged:note];
        }];
    }
    return self;
}

- (void)setup
{
}

@end


@implementation UVNetWorkInfoHelper

+ (instancetype)shareInstance
{
    static UVNetWorkInfoHelper *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [UVNetWorkInfoHelper new];
    });
    return __instance;
}

// 内网获取ip地址
- (NSString *)getIpAddresses
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

//运行商代码 网络运营商,取值: “46000” (即中国移动) ,“46001”(即中国联通),“46003”(即中国电信)  不强相关 忽略无卡
-(NSString *)getcarrierCode
{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry=[carrier carrierName];
    if ([currentCountry isEqualToString:@"中国移动"]) {
        return @"46000";
    }else if ([currentCountry isEqualToString:@"中国联通"]) {
        return @"46001";
    }else{
        return @"46003";
    }
}

- (HMNetWorkType)getNetWorkType
{
    HMNetWorkType strNetworkType = HMNetWorkUnknowType;
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_storage zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return HMNetWorkUnknowType;
    }
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        // if target host is reachable and no connection is required
        // then we'll assume (for now) that your on Wi-Fi
        strNetworkType = HMNetWorkWifiType;
    }
    if (
        ((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
        (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0
        )
    {
        // ... and the connection is on-demand (or on-traffic) if the
        // calling application is using the CFSocketStream or higher APIs
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            // ... and no [user] intervention is needed
            strNetworkType = HMNetWorkWifiType;
        }
    }
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
            
            if (currentRadioAccessTechnology)
            {
                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE])
                {
                    strNetworkType =  HMNetWork4GType; // 4G
                }
                else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
                {
                    strNetworkType =  HMNetWork2GType; //2G
                }
                else
                {
                    strNetworkType = HMNetWork3GType; //"3G";
                }
            }
        }
        else
        {
            if((flags & kSCNetworkReachabilityFlagsReachable) == kSCNetworkReachabilityFlagsReachable)
            {
                if ((flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection)
                {
                    if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired)
                    {
                        strNetworkType = HMNetWork2GType;//  "2G";
                    }
                    else
                    {
                        strNetworkType = HMNetWork2GType; //"3G";
                        
                    }
                }
            }
        }
    }
    return strNetworkType;
}

@end
