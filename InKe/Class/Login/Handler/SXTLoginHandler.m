//
//  SXTLoginHandler.m
//  InKe
//
//  Created by SJQ on 2018/4/29.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTLoginHandler.h"
#import "SXTMiaoBoModel.h"

@implementation SXTLoginHandler

+ (void)loginAccount:(NSString *)account passwd:(NSString *)passwd and:(SuccessBlock)success failed:(FailedBlock)failed
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 以二进制方式来传输
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    // 可以接受的类型 (可选)
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    NSString *utf = [[NSString stringWithFormat:@"%@/login",YL_LoginManger] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //入参
    NSDictionary *dic = @{@"email": account,
                          @"password": passwd,
                          };
    [manager GET:utf parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code = [dic objectForKey:@"code"];
        success(code);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}

+ (void)sendActivateCode:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 以二进制方式来传输
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    // 可以接受的类型 (可选)
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    NSString *utf = [[NSString stringWithFormat:@"%@/getCode",YL_LoginManger] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //入参
    NSDictionary *dic = @{@"email": email,
                          @"session": @"emailCode",
                          };
    [manager GET:utf parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code = [dic objectForKey:@"code"];
        success(code);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}

+ (void)resourceAccount:(NSString *)account passwd:(NSString *)passwd activateCode:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 以二进制方式来传输
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    // 可以接受的类型 (可选)
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    NSString *utf = [[NSString stringWithFormat:@"%@/register",YL_LoginManger] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //入参
    NSDictionary *dic = @{@"email": account,
                          @"password": passwd,
                          @"code": email,
                          @"session": @"emailCode",
                          };
    [manager GET:utf parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code = [dic objectForKey:@"code"];
        success(code);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}
//忘记密码
+ (void)fogetPasswdWithAccount:(NSString *)account passwd:(NSString *)passwd activateCode:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 以二进制方式来传输
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    // 可以接受的类型 (可选)
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    NSString *utf = [[NSString stringWithFormat:@"%@/revisePassword",YL_LoginManger] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //入参
    NSDictionary *dic = @{@"email": account,
                          @"password": passwd,
                          @"code": email,
                          @"session": @"emailCode",
                          };
    [manager GET:utf parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code = [dic objectForKey:@"code"];
        success(code);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}

//绑定手机号
+ (void)bindingMobile:(NSString *)mobile activaCode:(NSString *)activaCode and:(SuccessBlock)success failed:(FailedBlock)failed {
}
//获取手机验证码
+ (void)getMobileCode:(NSString *)mobile and:(SuccessBlock)success failed:(FailedBlock)failed {
}

+ (void)changeMobileWithActivateCode:(NSString *)mobile and:(SuccessBlock)success failed:(FailedBlock)failed {
}

+ (void)checkAccountExist:(NSString *)account and:(SuccessBlock)success failed:(FailedBlock)failed {
    
}

@end
