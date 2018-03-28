//
//  SXTNearLiveCollectionViewCell.h
//  InKe
//
//  Created by SJQ on 2018/3/26.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTLive.h"
#import "SXTNearModel.h"

@interface SXTNearLiveCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SXTLive * live;

- (void)setViewForMiaoBo:(SXTNearModel *)miaobo;

@end
