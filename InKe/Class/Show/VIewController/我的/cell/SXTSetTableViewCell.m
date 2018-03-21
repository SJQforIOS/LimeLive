//
//  SXTSetTableViewCell.m
//  InKe
//
//  Created by SJQ on 2018/3/21.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTSetTableViewCell.h"

@interface SXTSetTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cakeLabel;

@end

@implementation SXTSetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setCacheNum:(NSInteger)cacheNum {
    _cacheNum = cacheNum;
    self.cakeLabel.text = [NSString stringWithFormat:@"%ld",_cacheNum];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
