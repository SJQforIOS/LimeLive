//
//  SXTMeUserTableViewCell.m
//  InKe
//
//  Created by SJQ on 2018/4/16.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTMeUserTableViewCell.h"

@interface SXTMeUserTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *userTextLabel;

@end

@implementation SXTMeUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMiaoModel:(SXTMiaoBoModel *)miaoModel {
    _miaoModel = miaoModel;
    
    if ([miaoModel.smallpic isEqualToString:@"test_touxiang"]) {
        self.headImageView.image = [UIImage imageNamed:@"test_touxiang"];
    }else {
        [self.headImageView downloadImage:[NSString stringWithFormat:@"%@",miaoModel.smallpic] placeholder:@"default_room"];
    }
    _headImageView.layer.cornerRadius = 40/2;
    [_headImageView.layer setMasksToBounds:YES];
    
    _nickNameLabel.text = miaoModel.myname;
    if (miaoModel.sex == 0) {
        _sexImageView.image = [UIImage imageNamed:@"sexw"];
    } else {
        _sexImageView.image = [UIImage imageNamed:@"sexm"];
    }
    _userTextLabel.text = miaoModel.signatures;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
