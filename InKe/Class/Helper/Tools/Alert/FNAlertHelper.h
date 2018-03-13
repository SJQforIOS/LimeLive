//
//  FNAlertHelper.h
//  FengNiao
//
//  Created by NetEase on 16/8/31.
//  Copyright © 2016年 浙江翼信科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSTAlertController.h"

@interface FNAlertHelper : NSObject

/**
 @brief  模式对话框，选择一项（UIAlertView与与UIAlertController封装，根据不同ios版本对应选择调用方法）
 @param title        标题
 @param message      提示内容
 @param block        返回点击的按钮index,按照buttonsStatement按钮的顺序，从0开始
 @param cancelString 取消按钮 文本，必须以nil结束
 */
+ (PSTAlertController *)showAlertWithTitle:(NSString*)title
                                       msg:(NSString*)message
                               chooseBlock:(void (^)(NSInteger buttonIdx))block
                          buttonsStatement:(NSString*)cancelString, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief  模式对话框，选择一项（UIAlertView与与UIAlertController封装，根据不同ios版本对应选择调用方法）
 @param title        标题
 @param message      提示内容
 @param block        返回点击的按钮index,按照buttonsStatement按钮的顺序，从0开始
 @param cancelString 取消按钮 文本，必须以nil结束
 */
+ (PSTAlertController *)showAlertWithTitle:(NSString*)title
                                       msg:(NSString*)message
                               chooseBlock:(void (^)(NSInteger buttonIdx))block
                              buttonsArray:(NSArray<NSString*> *)buttonArray;


/**
 *  模式对话框（有输入框）
 *
 *  @param title            标题
 *  @param message          内容
 *  @param textFiledPholder 默认输入框文案
 *  @param block            返回点击的按钮index,按照buttonsStatement按钮的顺序，从0开始
 *  @param cancelString     取消按钮 文本，必须以nil结束
 */
+ (PSTAlertController *)showAlertWithTitle:(NSString*)title
                                       msg:(NSString*)message
                          textFiledPholder:(NSString *)textFiledPholder
                               chooseBlock:(void (^)(NSInteger buttonIdx, NSString *text))block
                          buttonsStatement:(NSString*)cancelString, ... NS_REQUIRES_NIL_TERMINATION;

//+ (NSMutableArray *)allAlertViewArray;

/**
 *  模式对话框（有输入框）
 *
 *  @param title            标题
 *  @param message          内容
 *  @param text             选中的文案
 *  @param textFiledPholder 默认输入框文案
 *  @param block            返回点击的按钮index,按照buttonsStatement按钮的顺序，从0开始
 *  @param cancelString     取消按钮 文本，必须以nil结束
 */
+ (PSTAlertController *)showAlertWithTitle:(NSString*)title
                                       msg:(NSString*)message
                                      text:(NSString*)text
                          textFiledPholder:(NSString *)textFiledPholder
                                  delegate:(id<UITextFieldDelegate>)delegate
                               chooseBlock:(void (^)(NSInteger buttonIdx, NSString *text))block
                          buttonsStatement:(NSString*)cancelString, ... NS_REQUIRES_NIL_TERMINATION;

@end
