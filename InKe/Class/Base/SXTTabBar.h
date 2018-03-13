//
//  SXTTabBar.h
//  InKe
//
//  Created by sjq on 17/8/28.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SXTTabBar;

typedef NS_ENUM(NSUInteger, SXTItemType) {
    SXTItemTypeLanch = 10,//启动直播
    SXTItemTypeLive = 100,//展示直播
    SXTItemTypeMe,//我的页面
    
};

typedef void(^TabBlock)(SXTTabBar *tabbar, SXTItemType idx);

@protocol  SXTTabBarDelegate <NSObject>

- (void)tabbar:(SXTTabBar *)tabbar clickButton:(SXTItemType) idx;

@end

@interface SXTTabBar : UIView

@property (nonatomic, weak) id<SXTTabBarDelegate> delegate;
@property (nonatomic, copy) TabBlock block;


@end
