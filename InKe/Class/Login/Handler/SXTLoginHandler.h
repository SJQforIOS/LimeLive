//
//  SXTLoginHandler.h
//  InKe
//
//  Created by SJQ on 2018/4/29.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTBaseHandler.h"

/*
 *处理JSON数据
 */

@interface SXTLoginHandler : SXTBaseHandler

/**
 *  登陆
 */
+ (void)loginAccount:(NSString *)account passwd:(NSString *)passwd and:(SuccessBlock)success failed:(FailedBlock)failed;
/**
 *  发送邮箱验证码
 */
+ (void)sendActivateCode:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed;
/**
 *  注册
 */
+ (void)resourceAccount:(NSString *)account passwd:(NSString *)passwd activateCode:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed;
/**
 *  忘记密码
 */
+ (void)fogetPasswdWithAccount:(NSString *)account passwd:(NSString *)passwd activateCode:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed;
/**
 *  绑定手机号
 */
+ (void)bindingMobile:(NSString *)mobile activaCode:(NSString *)activaCode and:(SuccessBlock)success failed:(FailedBlock)failed;
/**
 *  获取手机验证码
 */
+ (void)getMobileCode:(NSString *)mobile and:(SuccessBlock)success failed:(FailedBlock)failed;
/**
 *  修改绑定手机号
 */
+ (void)changeMobileWithActivateCode:(NSString *)mobile and:(SuccessBlock)success failed:(FailedBlock)failed;



@end
