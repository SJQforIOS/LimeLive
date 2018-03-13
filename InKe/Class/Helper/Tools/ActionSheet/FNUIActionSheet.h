//
//  FNUIActionSheet.h
//  FengNiao
//
//  Created by 吴孟钦 on 16/4/20.
//  Copyright © 2016年 浙江翼信科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FNActionSheetBlock)(NSInteger buttonIndex);
typedef void(^FNActionSheetCancelBlock)(NSInteger index);
#define kTapBackgroundCancelTag   0
#define kTapCancelBtnTag          1

@interface FNUIActionSheet : UIView

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *cancelButtonTitle;

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonList:(NSMutableArray *)otherButtonList;

//监听屏幕旋转
- (void)listeningRotating;

- (void)showFNActionSheetWithCompletionHandler:(FNActionSheetBlock)block;

/*kTapCancelBtnTag 点击取消按钮，kTapBackgroundCancelTag点击背景*/
- (void)actionSheetCancel:(FNActionSheetCancelBlock)block;

- (NSString *)buttonTitleAtIndex:(NSUInteger)index;

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

- (void)setButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size atIndex:(NSUInteger)index;

- (void)setCancelButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size;

@end


@interface FNUIActionSheetConfig : NSObject

+ (FNUIActionSheetConfig *) actionSheetConfig;

@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) CGFloat spaceSmall;

@property (nonatomic, assign) CGFloat titleFontSize;
@property (nonatomic, assign) CGFloat buttonFontSize;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *buttonTitleColor;
@property (nonatomic, strong) UIColor *splitColor;

@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemPressedColor;
@property (nonatomic, strong) NSString *defaultTextCancel;


@end
