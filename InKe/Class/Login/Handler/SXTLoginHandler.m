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
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *utf = [[NSString stringWithFormat:@"%@/login",YL_LoginManger] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //入参
    NSDictionary *dic = @{@"email": account,
                          @"password": passwd,
                          };
    [manager GET:utf parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
    
    
}

+ (void)sendActivateCode:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    // 以二进制方式来传输
//    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
//    // 可以接受的类型 (可选)
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSString *utf = [[NSString stringWithFormat:@"%@/getCode",YL_LoginManger] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    //入参
//    NSDictionary *dic = @{@"email": email,
//                          };
//    [manager GET:utf parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        success(dic);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failed(error);
//    }];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/getCode?=%@",YL_LoginManger,email]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session  = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError * _Nullable error) {
                                                NSLog(@"%@",data);
                                            }];
    [task resume];
    
    
    
}

+ (void)resourceAccount:(NSString *)account passwd:(NSString *)passwd activateCode:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed {
    
}

+ (void)fogetPasswdWithAccount:(NSString *)account passwd:(NSString *)passwd activateCode:(NSString *)email and:(SuccessBlock)success failed:(FailedBlock)failed {
    
}

+ (void)bindingMobile:(NSString *)mobile activaCode:(NSString *)activaCode and:(SuccessBlock)success failed:(FailedBlock)failed {
    
}

+ (void)getMobileCode:(NSString *)mobile and:(SuccessBlock)success failed:(FailedBlock)failed {
    
}

+ (void)changeMobileWithActivateCode:(NSString *)mobile and:(SuccessBlock)success failed:(FailedBlock)failed {
    
}

@end
