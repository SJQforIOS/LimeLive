//
//  SXTMacros.h
//  InKe
//
//  Created by sjq on 17/8/28.
//  Copyright © 2017年 sjq. All rights reserved.
//

#ifndef SXTMacros_h
#define SXTMacros_h

//当前视图的尺寸
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define RGB(x,y,z) [UIColor colorWithRed:(x/255.0) green:(y/255.0) blue:(z/255.0) alpha:1]

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#define UIColorFromRGB(rgbValue)              UIColorFromRGBA(rgbValue, 1.0)



// MARK: 系统宏定义
#define IOS11           ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0)
#define IOS10           ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0)
#define IOS9            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0)
#define IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define IOS8_2          ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.2)
#define IOS7            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)
#define IOS7_1          ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.1)

// MARK: 设备尺寸宏定义
#if TARGET_IPHONE_SIMULATOR
#define is3_5Screen ([[UIScreen mainScreen] bounds].size.height <= 480)
#define is4Screen   ([[UIScreen mainScreen] bounds].size.height == 568)
#define is4_7Screen ([[UIScreen mainScreen] bounds].size.height == 667)
#define is5_5Screen ([[UIScreen mainScreen] bounds].size.height == 736)
#else
#define is3_5Screen (is_iphone4)
#define is4Screen   (is_iphone5 || is_iphoneSE)
#define is4_7Screen (is_iphone6 || is_iphone7)
#define is5_5Screen (is_iphone6_Plus || is_iphone7_Plus)
#endif



#endif /* SXTMacros_h */
