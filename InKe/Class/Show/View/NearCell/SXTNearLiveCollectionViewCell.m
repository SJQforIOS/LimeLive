//
//  SXTNearLiveCollectionViewCell.m
//  InKe
//
//  Created by SJQ on 2018/3/26.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTNearLiveCollectionViewCell.h"

@interface SXTNearLiveCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SXTNearLiveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setLive:(SXTLive *)live {
    _live = live;
    self.nameLabel.text = live.creator.nick;
    if ([live.creator.portrait isEqualToString:@"test_touxiang"]) {
        self.headImageView.image = [UIImage imageNamed:@"test_touxiang"];
    }
}

- (void)setViewForMiaoBo:(SXTNearModel *)miaobo
{
    self.nameLabel.text = miaobo.nickname;
    
    if ([miaobo.photo isEqualToString:@"test_touxiang"]) {
        self.headImageView.image = [UIImage imageNamed:@"test_touxiang"];
    }else {
        [self.headImageView downloadImage:[NSString stringWithFormat:@"%@",miaobo.photo] placeholder:@"default_room"];
    }
}

@end
