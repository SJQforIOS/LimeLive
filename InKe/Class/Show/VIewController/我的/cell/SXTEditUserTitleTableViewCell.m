//
//  SXTEditUserTitleTableViewCell.m
//  InKe
//
//  Created by SJQ on 2018/3/1.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTEditUserTitleTableViewCell.h"


@interface SXTEditUserTitleTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *valueLabelRight;


@end

@implementation SXTEditUserTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitle:(NSString *)title values:(NSString *)value {
    self.titleLabel.text = title;
    self.valueLabel.text = value;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
