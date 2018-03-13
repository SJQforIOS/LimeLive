//
//  SXTMiaoBoModel.m
//  InKe
//
//  Created by sjq on 17/9/14.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTMiaoBoModel.h"

@implementation SXTMiaoBoModel

+(SXTMiaoBoModel *)modelWithDict:(NSDictionary *)dic
{
    return [[SXTMiaoBoModel alloc] initWithDict:dic];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        //解析
        self.smallpic = dict[@"smallpic"];
        self.bigpic = dict[@"bigpic"];
        self.flv = dict[@"flv"];
        self.gps = dict[@"gps"];
        self.myname = dict[@"myname"];
        self.allnum = dict[@"allnum"];
    }
    return self;
}

@end
