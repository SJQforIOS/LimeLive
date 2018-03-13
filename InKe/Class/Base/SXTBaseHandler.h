//
//  SXTBaseHandler.h
//  InKe
//
//  Created by sjq on 17/9/11.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *数据解析处理
 */

typedef void(^CompleteBlock)();         //处理完成事件
typedef void(^SuccessBlock)(id obj);    //处理事件成功
typedef void(^FailedBlock)(id obj);     //处理事件失败

@interface SXTBaseHandler : NSObject

@end
