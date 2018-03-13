//
//  SXTPlayViewController.h
//  InKe
//
//  Created by sjq on 17/9/12.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTBaseViewController.h"
#import "SXTLive.h"
#import "SXTMiaoBoModel.h"

/*
 *播放页
 */

@interface SXTPlayViewController : SXTBaseViewController

@property (nonatomic, strong) SXTLive *live;
@property (nonatomic, strong) SXTMiaoBoModel *miaoBoModel;

@end
