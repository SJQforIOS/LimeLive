//
//  SXTBaseViewController.h
//  InKe
//
//  Created by sjq on 17/8/28.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FNNavationBarType) {
    FNNavationBarType_Normal,          // 默认的，白色毛玻璃透明 (有线)
    FNNavationBarType_Green,           // 主题绿色 (无线) 【首页】
};

@interface SXTBaseViewController : UIViewController

- (void)setNavigationBarWithType:(FNNavationBarType)type;

@end
