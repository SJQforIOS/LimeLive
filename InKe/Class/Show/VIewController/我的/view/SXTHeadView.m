//
//  SXTHeadView.m
//  InKe
//
//  Created by SJQ on 2018/2/27.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTHeadView.h"

@interface SXTHeadView()

@property (nonatomic, strong) UIView *bodyView;
@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, strong) UIView *bodyLineView;
@property (nonatomic, strong) UIView *centerLineView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *niceNameLabel;
@property (nonatomic, strong) UIImageView *sexImageView;
@property (nonatomic, strong) UILabel *userIdLabel;
@property (nonatomic, strong) UIButton *lookUserBtn;

@property (nonatomic, strong) UIView *focusView;
@property (nonatomic, strong) UIView *fensiView;
@property (nonatomic, strong) UILabel *focesNumLabel;
@property (nonatomic, strong) UILabel *focesTitleLabel;
@property (nonatomic, strong) UILabel *fensiNumLabel;
@property (nonatomic, strong) UILabel *fensiTitleLabel;

@end

@implementation SXTHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _bodyView = [[UIView alloc] init];
    [self addSubview:_bodyView];
    _bodyView.backgroundColor = [UIColor whiteColor];
    
    _bodyLineView  = [[UIView alloc] init];
    [self addSubview:_bodyLineView];
    _bodyLineView.backgroundColor = [UIColor grayColor];
    
    _messageView = [[UIView alloc] init];
    [self addSubview:_messageView];
    _messageView.backgroundColor = [UIColor whiteColor];
    
    _centerLineView = [[UIView alloc] init];
    [self.messageView addSubview:_centerLineView];
    _centerLineView.backgroundColor = [UIColor grayColor];
    
    _headImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"test_touxiang"]];
    [_headImageView sizeToFit];
    [self.bodyLineView addSubview:_headImageView];
    
    _niceNameLabel = [[UILabel alloc] init];
    [self.bodyView addSubview:_niceNameLabel];
    _niceNameLabel.font = [UIFont systemFontOfSize:18];
    _niceNameLabel.textColor = [UIColor blackColor];
    _niceNameLabel.text = @"你比星光还要遥远";
    
    _userIdLabel = [[UILabel alloc] init];
    [self.bodyView addSubview:_userIdLabel];
    _userIdLabel.font = [UIFont systemFontOfSize:12];
    _userIdLabel.textColor = [UIColor grayColor];
    _userIdLabel.text = @"青柠号: 188818188181";
    
    _sexImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sexm"]];
    [_sexImageView sizeToFit];
    [self.bodyView addSubview:_sexImageView];
    
    _lookUserBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bodyView addSubview:_lookUserBtn];
    _lookUserBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_lookUserBtn setTitle:@"查看编辑主页" forState:(UIControlStateNormal)];
    [_lookUserBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _lookUserBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_lookUserBtn setImage:[UIImage imageNamed:@"ic_list_down"] forState:(UIControlStateNormal)];
    [_lookUserBtn addTarget:self action:@selector(lookUserAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    _focusView = [[UIView alloc] init];
    [self.messageView addSubview:_focusView];
    UITapGestureRecognizer *focusViewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusViewClick)];
    [_focusView addGestureRecognizer:focusViewTapGestureRecognizer];
    _focusView.userInteractionEnabled = YES;
    
    _fensiView = [[UIView alloc] init];
    [self.messageView addSubview:_fensiView];
    UITapGestureRecognizer *fensiViewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fensiViewClick)];
    [_fensiView addGestureRecognizer:fensiViewTapGestureRecognizer];
    _fensiView.userInteractionEnabled = YES;
    
    _focesNumLabel = [[UILabel alloc] init];
    [self.focusView addSubview:_focesNumLabel];
    _focesNumLabel.font = [UIFont systemFontOfSize:18];
    _focesNumLabel.text = @"11";
    
    _focesTitleLabel = [[UILabel alloc] init];
    [self.focusView addSubview:_focesTitleLabel];
    _focesTitleLabel.font = [UIFont systemFontOfSize:12];
    _focesTitleLabel.text = @"我的关注";
    _focesTitleLabel.textColor = [UIColor grayColor];
    
    _fensiNumLabel = [[UILabel alloc] init];
    [self.fensiView addSubview:_fensiNumLabel];
    _fensiNumLabel.font = [UIFont systemFontOfSize:18];
    _fensiNumLabel.text = @"11";
    
    _fensiTitleLabel = [[UILabel alloc] init];
    [self.fensiView addSubview:_fensiTitleLabel];
    _fensiTitleLabel.font = [UIFont systemFontOfSize:12];
    _fensiTitleLabel.text = @"我的粉丝";
    _fensiTitleLabel.textColor = [UIColor grayColor];
    
    
    
    [_bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@90);
    }];
    
    [_bodyLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.bodyView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    
    [_messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodyLineView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    [_centerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.messageView);
        make.width.equalTo(@0.5);
        make.height.equalTo(@30);
    }];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bodyView.mas_centerY);
        make.left.equalTo(self.bodyView.mas_left).offset(20);
        make.width.height.equalTo(@60);
    }];
    _headImageView.layer.cornerRadius = 30;
    _headImageView.layer.masksToBounds = YES;
    
    [_niceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(20);
        make.centerY.equalTo(self.bodyView.mas_centerY).offset(-15);
    }];
    [_userIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(20);
        make.centerY.equalTo(self.bodyView.mas_centerY).offset(15);
    }];
    [_sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.niceNameLabel.mas_right).offset(5);
        make.centerY.equalTo(self.niceNameLabel.mas_centerY);
        make.width.height.equalTo(@15);
    }];
    [_lookUserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bodyView.mas_right).offset(-5);
        make.centerY.equalTo(self.userIdLabel.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    _lookUserBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
    _lookUserBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_lookUserBtn.currentImage.size.width, 0, _lookUserBtn.currentImage.size.width+10);
    
    [_focusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.messageView.mas_centerY);
        make.centerX.equalTo(self.messageView.mas_centerX).offset(-SCREEN_WIDTH/4);
        make.width.height.equalTo(@60);
    }];
    [_fensiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.messageView.mas_centerY);
        make.centerX.equalTo(self.messageView.mas_centerX).offset(SCREEN_WIDTH/4);
        make.width.height.equalTo(@60);
    }];
    [_focesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.focusView.mas_centerX);
        make.centerY.equalTo(self.focusView.mas_centerY).offset(-10);
    }];
    [_focesTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.focusView.mas_centerX);
        make.centerY.equalTo(self.focusView.mas_centerY).offset(10);
    }];
    [_fensiNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fensiView.mas_centerX);
        make.centerY.equalTo(self.fensiView.mas_centerY).offset(-10);
    }];
    [_fensiTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fensiView.mas_centerX);
        make.centerY.equalTo(self.fensiView.mas_centerY).offset(10);
    }];
    
    
    
}

- (void)lookUserAction:(id)sender
{
    NSLog(@"去编辑页");
    if (_editUsrBlock) {
        _editUsrBlock();
    }
}

- (void)focusViewClick
{
    NSLog(@"点击关注");
    if (_focusUserBlock) {
        _focusUserBlock();
    }
}

- (void)fensiViewClick
{
    NSLog(@"查看粉丝");
    if (_fensiUsrBlock) {
        _fensiUsrBlock();
    }
}

@end
