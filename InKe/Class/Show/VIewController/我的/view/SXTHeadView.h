//
//  SXTHeadView.h
//  InKe
//
//  Created by SJQ on 2018/2/27.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXTHeadView : UIView

@property (nonatomic, copy) dispatch_block_t editUsrBlock;//编辑个人信息
@property (nonatomic, copy) dispatch_block_t focusUserBlock;//查看关注列表
@property (nonatomic, copy) dispatch_block_t fensiUsrBlock;//查看粉丝列表

@end
