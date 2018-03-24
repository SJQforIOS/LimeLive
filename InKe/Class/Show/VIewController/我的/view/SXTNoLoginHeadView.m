//
//  SXTNoLoginHeadView.m
//  InKe
//
//  Created by SJQ on 2018/3/24.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTNoLoginHeadView.h"

@interface SXTNoLoginHeadView ()

@property (nonatomic, strong) UIView *bodyView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *pleaseLoginLabel;
@property (nonatomic, strong) UIImageView *selectImageView;

@end

@implementation SXTNoLoginHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _bodyView = [[UIView alloc] init];
    [self addSubview:_bodyView];
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [_bodyView addGestureRecognizer:labelTapGestureRecognizer];
    _bodyView.userInteractionEnabled = YES;
    
    _headImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"test_touxiang"]];
    [_headImageView sizeToFit];
    [_bodyView addSubview:_headImageView];
    
    _pleaseLoginLabel = [[UILabel alloc] init];
    [_bodyView addSubview:_pleaseLoginLabel];
    _pleaseLoginLabel.text = @"请登录";
    _pleaseLoginLabel.font = [UIFont systemFontOfSize:18];
    _pleaseLoginLabel.textColor = [UIColor blackColor];
    
    _selectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_list_down"]];
    [_selectImageView sizeToFit];
    [_bodyView addSubview:_selectImageView];
    
    [_bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(20);
        make.width.height.equalTo(@60);
    }];
    _headImageView.layer.cornerRadius = 30;
    _headImageView.layer.masksToBounds = YES;
    
    [_pleaseLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.headImageView.mas_right).offset(20);
    }];
    
    [_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-14);
    }];
    
    
}

- (void)labelClick {
    if (_goLoginBlock) {
        _goLoginBlock();
    }
}

@end
