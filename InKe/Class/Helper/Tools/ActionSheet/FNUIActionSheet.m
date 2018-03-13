//
//  FNUIActionSheet.m
//  FengNiao
//
//  Created by 吴孟钦 on 16/4/20.
//  Copyright © 2016年 浙江翼信科技有限公司. All rights reserved.
//

#import "FNUIActionSheet.h"
#import <objc/runtime.h>

#define kLabelLeft 15.0
#define kLabelTop  10.0

@interface FNUIActionSheet()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *buttonView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) NSMutableArray *buttonTitleArray;

@end

CGFloat contentViewWidth;
CGFloat contentViewHeight;
static char kUIActionSheetBlockAddress;
static char kUIActionSheetCancelBlockAddress;

@implementation FNUIActionSheet


- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        FNUIActionSheetConfig *config = [FNUIActionSheetConfig actionSheetConfig];
        _title = title;
        _cancelButtonTitle = cancelButtonTitle?cancelButtonTitle:config.defaultTextCancel;
        _buttonArray = [NSMutableArray array];
        _buttonTitleArray = [NSMutableArray array];
        
        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles) {
            [_buttonTitleArray addObject:otherButtonTitles];
            while (1) {
                NSString *otherButtonTitle = va_arg(args, NSString *);
                if (otherButtonTitle == nil) {
                    break;
                } else {
                    [_buttonTitleArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);
        
        [self addGesForBackground:config];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonList:(NSMutableArray *)otherButtonList {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        FNUIActionSheetConfig *config = [FNUIActionSheetConfig actionSheetConfig];
        _title = title;
        _cancelButtonTitle = cancelButtonTitle?cancelButtonTitle:config.defaultTextCancel;
        
        _buttonArray = [NSMutableArray array];
        _buttonTitleArray = [NSMutableArray array];
        
        [_buttonTitleArray addObjectsFromArray:otherButtonList];
        
        [self addGesForBackground:config];
    }
    return self;
}

- (void)addGesForBackground:(FNUIActionSheetConfig *)config{
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    _backgroundView = [[UIView alloc] initWithFrame:self.frame];
    _backgroundView.alpha = 0;
    _backgroundView.backgroundColor = config.backgroundColor;
    [_backgroundView addGestureRecognizer:tapGestureRecognizer];
    [self addSubview:_backgroundView];
    
    [self initContentView];
}


- (void)initContentView {
    contentViewWidth =  self.frame.size.width;
    contentViewHeight = 0;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = UIColorFromRGBA(0xe5e5e5, 1.0);
    
    _buttonView = [[UIView alloc] init];
    _buttonView.backgroundColor = [UIColor whiteColor];
    
    [self initTitle];
    [self initButtons];
    [self initCancelButton];
    
    _contentView.frame = CGRectMake((self.frame.size.width - contentViewWidth ) / 2, self.frame.size.height, contentViewWidth, contentViewHeight);
    [self addSubview:_contentView];
}

- (void)initTitle {
    if (_title != nil && ![_title isEqualToString:@""]) {
        FNUIActionSheetConfig *config = [FNUIActionSheetConfig actionSheetConfig];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = _title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = config.titleColor;
        _titleLabel.font = [UIFont systemFontOfSize:config.titleFontSize];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 0;
        CGFloat titleHeight;
        NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : _titleLabel.font, NSParagraphStyleAttributeName : style };
        CGRect rect = [_title boundingRectWithSize:CGSizeMake(contentViewWidth-kLabelLeft*2, 500) options:options attributes:attributes context:nil];
        titleHeight = ceilf(rect.size.height)<config.buttonHeight-kLabelTop*2?config.buttonHeight-kLabelTop*2:ceilf(rect.size.height);
        _titleLabel.frame = CGRectMake(kLabelLeft, kLabelTop, contentViewWidth-kLabelLeft*2, titleHeight);
        [_buttonView addSubview:_titleLabel];
        contentViewHeight += titleHeight+kLabelTop*2;
    }
}

- (void)initButtons {
    if (_buttonTitleArray.count > 0) {
        NSInteger count = _buttonTitleArray.count;
        FNUIActionSheetConfig *config = [FNUIActionSheetConfig actionSheetConfig];
        for (int i = 0; i < count; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, contentViewHeight, contentViewWidth, 0.5)];
            lineView.backgroundColor = config.splitColor;
            [_buttonView addSubview:lineView];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, contentViewHeight + 1, contentViewWidth, config.buttonHeight)];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
            button.titleLabel.font = [UIFont systemFontOfSize:config.buttonFontSize];
            [button setTitle:_buttonTitleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:config.buttonTitleColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArray addObject:button];
            [_buttonView addSubview:button];
            contentViewHeight += lineView.frame.size.height + button.frame.size.height;
        }
        _buttonView.frame = CGRectMake(0, 0, contentViewWidth, contentViewHeight);
        _buttonView.layer.masksToBounds = YES;
        [_contentView addSubview:_buttonView];
    }
}

- (void)initCancelButton {
    if (_cancelButtonTitle != nil) {
        FNUIActionSheetConfig *config = [FNUIActionSheetConfig actionSheetConfig];
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, contentViewHeight + config.spaceSmall, contentViewWidth, config.buttonHeight)];
        [_cancelButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[UIImage imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:config.buttonFontSize];
        [_cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        [_cancelButton setTitleColor:config.buttonTitleColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_cancelButton];
        contentViewHeight += config.spaceSmall + _cancelButton.frame.size.height;
    }
}

- (void)showFNActionSheetWithCompletionHandler:(FNActionSheetBlock)block
{
    objc_setAssociatedObject(self,&kUIActionSheetBlockAddress,block,OBJC_ASSOCIATION_COPY);
    [self show];
}

- (void)actionSheetCancel:(FNActionSheetCancelBlock)block
{
    objc_setAssociatedObject(self,&kUIActionSheetCancelBlockAddress,block,OBJC_ASSOCIATION_COPY);
}

- (void)show {
    
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self];
    [self addAnimation];
}

- (void)hide {
    FNActionSheetCancelBlock block = objc_getAssociatedObject(self, &kUIActionSheetCancelBlockAddress);
    if (block)
    {
        block(kTapBackgroundCancelTag);
        objc_setAssociatedObject(self, &kUIActionSheetCancelBlockAddress, nil, OBJC_ASSOCIATION_COPY);
    }
    [self removeAnimation];
}

- (NSString *)buttonTitleAtIndex:(NSUInteger)index
{
    NSString *title;
    if (index < _buttonTitleArray.count)
    {
        title = _buttonTitleArray[index];
    }
    return title;
}

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _titleLabel.textColor = color;
    }
    
    if (size > 0) {
        _titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size atIndex:(NSUInteger)index {
    UIButton *button;
    if (index<_buttonArray.count)
    {
        button = _buttonArray[index];
    }
    if (color != nil) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (bgcolor != nil) {
        [button setBackgroundColor:bgcolor];
    }
    
    if (size > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setCancelButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size {
    if (color != nil) {
        [_cancelButton setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (bgcolor != nil) {
        [_cancelButton setBackgroundColor:bgcolor];
    }
    
    if (size > 0) {
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)addAnimation {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height - _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0.5;
    } completion:^(BOOL finished) {
    }];
}

- (void)removeAnimation {
    [UIView animateWithDuration:0.15 delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }];
}

- (void)buttonPressed:(UIButton *)button {
    
    for (int i = 0; i < _buttonArray.count; i++) {
        if (button == _buttonArray[i]) {
            FNActionSheetBlock block = objc_getAssociatedObject(self, &kUIActionSheetBlockAddress);
            if (block)
            {
                block(i);
                objc_setAssociatedObject(self, &kUIActionSheetBlockAddress, nil, OBJC_ASSOCIATION_COPY);
            }
            break;
        }
    }
    [self removeAnimation];
}

- (void)cancelButtonPressed:(UIButton *)button {
    
    FNActionSheetCancelBlock block = objc_getAssociatedObject(self, &kUIActionSheetCancelBlockAddress);
    if (block)
    {
        block(kTapCancelBtnTag);
        objc_setAssociatedObject(self, &kUIActionSheetCancelBlockAddress, nil, OBJC_ASSOCIATION_COPY);
    }
    [self removeAnimation];
}

- (void)listeningRotating{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
}

- (void)onDeviceOrientationChange{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationPortrait:{
            [self backOrientationPortrait];
            break;
        }
            
        case UIInterfaceOrientationLandscapeLeft:{
            
            [self setDeviceOrientationLandscapeLeft];
            break;
        }
            
        case UIInterfaceOrientationLandscapeRight:{
            
            [self setDeviceOrientationLandscapeRight];
            break;
            
        }
        default:
            break;
    }
}

- (void)recalculateFrame
{
    CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);;
    _backgroundView.frame = frame;
    self.frame = frame;
    CGRect buttonViewFrame = _buttonView.frame;
    buttonViewFrame.size.width = CGRectGetWidth(self.frame);
    _buttonView.frame = buttonViewFrame;
    for (UIView *view in _buttonView.subviews) {
        CGRect tempFrame = view.frame;
        if ([view isKindOfClass:[UILabel class]])
        {
            tempFrame.size.width = CGRectGetWidth(self.frame);
        }
        else
        {
            tempFrame.size.width = CGRectGetWidth(self.frame);
        }
        view.frame = tempFrame;
    }
    _contentView.frame = CGRectMake(0, self.frame.size.height-contentViewHeight, [[UIScreen mainScreen] bounds].size.width, contentViewHeight);
    CGRect cancelBtnFrame = _cancelButton.frame;
    cancelBtnFrame.size.width = CGRectGetWidth(self.frame);
    _cancelButton.frame = cancelBtnFrame;
}
- (void)backOrientationPortrait
{
    [self recalculateFrame];
}

- (void)setDeviceOrientationLandscapeLeft
{
    [self recalculateFrame];
}

- (void)setDeviceOrientationLandscapeRight
{
    [self recalculateFrame];
}

@end

@implementation FNUIActionSheetConfig

+ (FNUIActionSheetConfig *) actionSheetConfig
{
    static FNUIActionSheetConfig *config;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        
        config = [FNUIActionSheetConfig new];
    });
    return config;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.buttonHeight   = 50.0f;
        self.spaceSmall     = 5.0f;
        
        self.titleFontSize  = 15.0f;
        self.buttonFontSize = 17.0f;
        
        self.backgroundColor    = UIColorFromRGB(0x000000);
        self.buttonTitleColor   = UIColorFromRGB(0x000000);
        self.titleColor         = UIColorFromRGB(0x000000);
        self.splitColor         = UIColorFromRGB(0xebebeb);
        
        self.itemNormalColor    = UIColorFromRGB(0x333333);
        self.itemPressedColor   = UIColorFromRGB(0xEFEFEF);
        
        self.defaultTextCancel  = NSLocalizedString(@"CANCEL", @"");
    }
    
    return self;
}

@end
