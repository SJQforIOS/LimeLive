//
//  UIColor+HMCategory.m
//  HMReader
//
//  Created by 伍学俊 on 2017/7/3.
//  Copyright © 2017年 伍学俊. All rights reserved.
//

#import "UIColor+HMCategory.h"

@implementation UIColor (HMCategory)

- (NSString *)hm_hexString
{
    CGColorSpaceModel colorSpace = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r, g, b, a;
    
    if (colorSpace == kCGColorSpaceModelMonochrome) {
        r = components[0];
        g = components[0];
        b = components[0];
        a = components[1];
    }
    else {
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    // 如果透明度为1，那么只返回rgb值
    if (fabs(a - 1.0) < 1e-3) {
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
                lroundf(r * 255),
                lroundf(g * 255),
                lroundf(b * 255)];
    } else {
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX",
                lroundf(r * 255),
                lroundf(g * 255),
                lroundf(b * 255),
                lroundf(a * 255)];
    }
}

@end
