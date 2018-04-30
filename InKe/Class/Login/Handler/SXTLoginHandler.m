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
    NSString *utf = [[NSString stringWithFormat:@"%@",YL_LoginManger] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //入参
    NSDictionary *dic = @{@"email": account,
                          @"oldPw": passwd,
                          };
    [manager GET:utf parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *dataSourceArr = [[NSMutableArray alloc]init];
        for (NSDictionary *arr in dic[@"data"][@"list"]) {
            SXTMiaoBoModel *article = [SXTMiaoBoModel modelWithDict:arr];
            [dataSourceArr addObject:article];//赋值
        }
        success(dataSourceArr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
    
    
}

@end
