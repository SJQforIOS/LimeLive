//
//  SXTLiveCell.m
//  bjsxt-inke
//
//  Created by 大欢 on 16/9/2.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "SXTLiveCell.h"

@interface SXTLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView; //头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;    //直播名字
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;//所在地区
@property (weak, nonatomic) IBOutlet UILabel *onLineLabel;  //在线人数
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;//直播封面


@end

@implementation SXTLiveCell

- (void)setLive:(SXTLive *)live {
    
    _live = live;
    

    self.nameLabel.text = live.creator.nick;
    self.locationLabel.text = live.city;
    self.onLineLabel.text = [@(live.onlineUsers) stringValue];
    
    if ([live.creator.portrait isEqualToString:@"test_touxiang"]) {
        self.headView.image = [UIImage imageNamed:@"test_touxiang"];
        self.bigImageView.image = [UIImage imageNamed:@"test_dog"];
    }
}

- (void)setViewForMiaoBo:(SXTMiaoBoModel *)miaobo
{
    self.nameLabel.text = miaobo.myname;
    self.locationLabel.text = miaobo.gps;
    self.onLineLabel.text = [NSString stringWithFormat:@"%@", miaobo.allnum];
    
    if ([miaobo.smallpic isEqualToString:@"test_touxiang"]) {
        self.headView.image = [UIImage imageNamed:@"test_touxiang"];
        self.bigImageView.image = [UIImage imageNamed:@"test_dog"];
    }else {
        [self.headView downloadImage:[NSString stringWithFormat:@"%@",miaobo.smallpic] placeholder:@"default_room"];
        [self.bigImageView downloadImage:[NSString stringWithFormat:@"%@",miaobo.bigpic] placeholder:@"default_room"];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
