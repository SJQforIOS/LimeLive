//
//  UIColor+HMCategory.h
//  HMReader
//
//  Created by 伍学俊 on 2017/7/3.
//  Copyright © 2017年 伍学俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HMCategory)

/**
 * 获取颜色的rgba 16进制描述
 * eg: #AABBCC
 * 获取的颜色均为大写字母
 */
- (NSString *)hm_hexString;

@end
