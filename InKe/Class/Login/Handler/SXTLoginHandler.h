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

/**
 检测用户是否已经注册

 @param account 账号邮箱
 */
+ (void)checkAccountExist:(NSString *)account and:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 获取用户详细信息

 @param email 用户邮箱
 */
+ (void)getUserDetailWithEmail:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 获取关注列表

 @param email 用户邮箱
 */
+ (void)getFocusUserListWithEmail:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed;
/**
 获取粉丝列表
 
 @param email 用户邮箱
 */
+ (void)getFensiUserListWithEmail:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 修改个人信息

 @param email 用户邮箱
 @param phone 绑定号码
 @param myname 昵称
 @param gps 城市
 @param sex 性别
 @param birth 生日
 */
+ (void)changeUserDetailWithEmail:(NSString *)email andPhone:(NSString *)phone andMyName:(NSString *)myname andGps:(NSString *)gps andSex:(int)sex andBirth:(NSString *)birth;


@end
