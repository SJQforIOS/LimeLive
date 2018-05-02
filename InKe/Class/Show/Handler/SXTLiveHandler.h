//
//  SXTLiveHandler.h
//  InKe
//
//  Created by sjq on 17/9/11.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTBaseHandler.h"

/*
 *处理JSON数据
 */

@interface SXTLiveHandler : SXTBaseHandler

/**
 *  获取热门直播信息
 */
+ (void)executeGetHotLiveTaskWithSuccess:(NSInteger)page and:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 *  获取附近的直播信息
 */

+ (void)executeGetNearLiveTaskWithSuccess:(NSInteger)page and:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 *  关注
 */
+ (void)setFocusUserTaskWithSuccess:(NSString *)account andLiveUser:(NSString *)liveUser and:(SuccessBlock)success failed:(FailedBlock)failed;

@end
