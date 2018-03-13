//
//  SXTMainViewController.m
//  InKe
//
//  Created by sjq on 17/8/28.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTMainViewController.h"
#import "SXTMainTopView.h"

@interface SXTMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) SXTMainTopView * topView;

@end

@implementation SXTMainViewController

- (SXTMainTopView *)topView {
    
    if (!_topView) {
        _topView = [[SXTMainTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.dataList];
        
        @weakify(self);
        _topView.block = ^(NSInteger tag) {
            @strongify(self);
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            [self.contentScrollView setContentOffset:point animated:YES];
            
        };
    }
    return _topView;
}

- (NSArray *)dataList
{
    if (!_dataList) {
        _dataList = @[@"关注",@"热门",@"附近"];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)initUI
{
    //添加左右按钮
    [self setNav];
    
    //添加子视图控制器
    [self setChildViewControllers];
}

- (void)setChildViewControllers
{
    NSArray *vcNames = @[@"SXTFocuseViewController",@"SXTHotViewController",@"SXTNearViewController"];
    for (NSInteger i = 0; i < vcNames.count; i ++) {
        NSString *vcName = vcNames[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = self.dataList[i];
        [self addChildViewController:vc];
    }
    
    //将子控制器的view,加到mainVC的scrollView上
    
    //设置scrollView的frame
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.dataList.count, 0);
    //默认先展示第二个页面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    //进入主控制器加载第一个页面
    [self scrollViewDidEndDecelerating:self.contentScrollView];
    
}

- (void)setNav
{
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
}

//动画结束调用代理
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = SCREEN_WIDTH;//scrollView.frame.size.width;
    CGFloat height = SCREEN_HEIGHT - 64;
    CGFloat offset = scrollView.contentOffset.x;
    //获取索引值
    NSInteger idx = offset / width;
    //索引值联动topView
    [self.topView scrolling:idx];
    //根据索引值返回vc引用
    UIViewController * vc = self.childViewControllers[idx];
    //判断当前vc是否执行过viewdidLoad
    if ([vc isViewLoaded]) return;
    //设置子控制器view的大小
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
    //将子控制器的view加入scrollview上
    [scrollView addSubview:vc.view];
}

//减速结束时调用加载子控制器view的方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
