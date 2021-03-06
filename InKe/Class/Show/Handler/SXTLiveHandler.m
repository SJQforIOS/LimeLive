//
//  SXTLiveHandler.m
//  InKe
//
//  Created by sjq on 17/9/11.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTLiveHandler.h"
#import "AFNetworking/AFNetworking.h"
#import "SXTLive.h"
#import "SXTMiaoBoModel.h"
#import "SXTNearModel.h"

@implementation SXTLiveHandler

+ (void)executeGetHotLiveTaskWithSuccess:(NSInteger)page and:(SuccessBlock)success failed:(FailedBlock)failed
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 以二进制方式来传输
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    // 可以接受的类型 (可选)
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *utf = [[NSString stringWithFormat:@"%@?page=%ld",API_HotLive, (long)page] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:utf parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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

+ (void)executeGetNearLiveTaskWithSuccess:(NSInteger)page and:(SuccessBlock)success failed:(FailedBlock)failed
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 以二进制方式来传输
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    // 可以接受的类型 (可选)
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *utf = [[NSString stringWithFormat:@"%@?page=%ld",API_NearLive, (long)page] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:utf parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *dataSourceArr = [[NSMutableArray alloc]init];
        for (NSDictionary *arr in dic[@"data"][@"list"]) {
            SXTNearModel *article = [SXTNearModel modelWithDict:arr];
            [dataSourceArr addObject:article];//赋值
        }
        success(dataSourceArr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}

+ (void)setFocusUserTaskWithSuccess:(NSString *)account andLiveUser:(NSString *)liveUser and:(SuccessBlock)success failed:(FailedBlock)failed
{
    
}

+ (void)executeGetFocustListTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
}

+ (void)executeGetFensiListTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
}

@end
