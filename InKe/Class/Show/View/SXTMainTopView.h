//
//  SXTMainTopView.h
//  InKe
//
//  Created by sjq on 17/9/7.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTopBlock)(NSInteger tag);

@interface SXTMainTopView : UIView

@property (nonatomic, copy) MainTopBlock block;

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles;

- (void)scrolling:(NSInteger)tag;

@end
