//
//  SXTLocationManager.h
//  InKe
//
//  Created by SJQ on 2018/3/26.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationBlock)(NSString *lat, NSString *lon);

@interface SXTLocationManager : NSObject

+ (instancetype)sharedManager;

- (void)getGps:(LocationBlock )block;

@end
