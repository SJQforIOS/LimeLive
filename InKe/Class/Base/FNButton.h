//
//  FNButton.h
//  FengNiao
//
//  Created by 黄耀武 on 2017/12/25.
//  Copyright © 2017年 浙江翼信科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNButton : NSObject

+ (UIButton *)commonNavBackButton;

+ (UIButton *)commonWhiteBackButton;

+ (UIButton *)messageListRightBarButton;

+ (UIButton *)commonBackButtonWithColor:(UIColor *)color;

+ (UIButton *)commonBackButtonWithTitle:(NSString *)title color:(UIColor *)color;

+ (UIButton *)commonRightBarButtonWithImage:(UIImage *)image;

+ (UIButton *)commonWhiteBackButtonWithImage;

@end
