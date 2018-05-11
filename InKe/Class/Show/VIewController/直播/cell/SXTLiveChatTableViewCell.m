//
//  SXTLiveChatTableViewCell.m
//  InKe
//
//  Created by SJQ on 2018/5/3.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTLiveChatTableViewCell.h"

@interface SXTLiveChatTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@end

@implementation SXTLiveChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCommentModel:(SXTCommentModel *)commentModel {
    _commentModel = commentModel;
    //初始化富文本对象：
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@",commentModel.userName,commentModel.userComment]];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:UIColorFromRGB(0xA4DEF1)
                          range:NSMakeRange(0, commentModel.userName.length+1)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor whiteColor]
                          range:NSMakeRange(commentModel.userName.length+1, commentModel.userComment.length)];
    //设置label的富文本属性
    _bodyLabel.attributedText = attributedStr;
    _bodyLabel.numberOfLines = 0;
}

+ (CGFloat)cellHeightWithMsg:(NSString *)msg {
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"%@:",msg];
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(SCREEN_WIDTH*3/4, CGFLOAT_MAX)];
    return size.height+14;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
