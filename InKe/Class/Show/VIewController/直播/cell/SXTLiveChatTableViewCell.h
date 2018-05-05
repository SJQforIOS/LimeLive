//
//  SXTLiveChatTableViewCell.h
//  InKe
//
//  Created by SJQ on 2018/5/3.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTCommentModel.h"

@interface SXTLiveChatTableViewCell : UITableViewCell

@property (nonatomic, strong) SXTCommentModel *commentModel;

+ (CGFloat)cellHeightWithMsg:(NSString *)msg;

@end
