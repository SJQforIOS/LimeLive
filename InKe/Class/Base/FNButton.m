//
//  FNButton.m
//  FengNiao
//
//  Created by 黄耀武 on 2017/12/25.
//  Copyright © 2017年 浙江翼信科技有限公司. All rights reserved.
//

#import "FNButton.h"

#define kButtonFrameWidth 50
#define kButtonFrameHeight 40

#define kIMButtonFrameWidth 40
#define kWebViewButtonFrameWidth 36

#define kTextButtonFrameWidth 80

#define kBackLabelFontSize 15

@implementation FNButton

+ (UIButton *)commonNavBackButton
{
    return [FNButton commonBackButtonWithColor:[UIColor blackColor]];
}

+ (UIButton *)commonWhiteBackButton {
    return [FNButton commonBackButtonWithColor:[UIColor whiteColor]];
}

+ (UIButton *)commonBackButtonWithColor:(UIColor *)color {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, kButtonFrameWidth, kButtonFrameHeight)];
    //guidanceArrow
    [button setImage:[UIImage imageNamed:@"icon_navigation_back"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_navigation_back"] forState:UIControlStateHighlighted];
    
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:kBackLabelFontSize];
    
    button.exclusiveTouch = YES;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:[color colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [button setTitleColor:[color colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
    button.titleLabel.font = [UIFont systemFontOfSize:kBackLabelFontSize];
    return button;
}

+ (UIButton *)commonBackButtonWithTitle:(NSString *)title color:(UIColor *)color {
    UIButton *button = [FNButton commonBackButtonWithColor:color];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    
    CGSize size = [button sizeThatFits:CGSizeMake(CGFLOAT_MAX, button.height)];
    button.width = size.width + button.titleEdgeInsets.left;
    
    return button;
}

+ (UIButton *)messageListRightBarButton
{
    UIImage *buttonNormal = [UIImage imageNamed:@"icon_home_add"];
    UIImage *buttonPressed= [UIImage imageNamed:@"icon_home_add"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonNormal forState:UIControlStateNormal];
    [button setImage:buttonPressed forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, 0, kButtonFrameWidth, kButtonFrameHeight)];
    
    return button;
}

+ (UIButton *)commonRightBarButtonWithImage:(UIImage *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, 0, kIMButtonFrameWidth, kButtonFrameHeight)];
    
    return button;
}

+ (UIButton *)commonWhiteBackButtonWithImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icon_navigation_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_navigation_back_white"] forState:UIControlStateHighlighted];
    
    [button setFrame:CGRectMake(0, 0, kButtonFrameWidth, kButtonFrameHeight)];
    button.exclusiveTouch = YES;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
    button.titleLabel.font = [UIFont systemFontOfSize:kBackLabelFontSize];
    return button;
}

@end
