//
//  SXTEditUserHeadImageTableViewCell.m
//  InKe
//
//  Created by SJQ on 2018/3/1.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTEditUserHeadImageTableViewCell.h"

@interface SXTEditUserHeadImageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation SXTEditUserHeadImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headImageView.layer.cornerRadius = 70/2;
    [_headImageView.layer setMasksToBounds:YES];
}

- (void)setMiaoModel:(SXTMiaoBoModel *)miaoModel {
    _miaoModel = miaoModel;
    
    if ([miaoModel.smallpic isEqualToString:@"test_touxiang"]) {
        self.headImageView.image = [UIImage imageNamed:@"test_touxiang"];
    }else {
        [self.headImageView downloadImage:[NSString stringWithFormat:@"%@",miaoModel.smallpic] placeholder:@"default_room"];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
