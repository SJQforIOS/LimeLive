//
//  SXTNearModel.m
//  InKe
//
//  Created by SJQ on 2018/3/26.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTNearModel.h"

@implementation SXTNearModel

+(SXTNearModel *)modelWithDict:(NSDictionary *)dic
{
    return [[SXTNearModel alloc] initWithDict:dic];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        //解析
        self.nickname = dict[@"nickname"];
        self.flv = dict[@"flv"];
        self.photo = dict[@"photo"];
        self.position = dict[@"position"];
        self.roomid = dict[@"roomid"];
        self.useridx = dict[@"useridx"];
    }
    return self;
}

@end
