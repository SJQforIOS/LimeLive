//
//  SXTTabBarViewController.m
//  InKe
//
//  Created by sjq on 17/8/28.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTTabBarViewController.h"
#import "SXTTabBar.h"
#import "SXTBaseNavViewController.h"
#import "SXTLaunchViewController.h"

@interface SXTTabBarViewController ()<SXTTabBarDelegate>

@property (nonatomic, strong) SXTTabBar *sxtTabBar;

@end

@implementation SXTTabBarViewController

- (SXTTabBar *)sxtTabBar
{
    if (!_sxtTabBar) {
        _sxtTabBar = [[SXTTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _sxtTabBar.delegate = self;
    }
    return _sxtTabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载控制器
    [self configViewControllers];
    
    //加载tabbar
    [self.tabBar addSubview:self.sxtTabBar];
    
    //删除tabbar的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
}

- (void)configViewControllers
{
    NSMutableArray * array = [NSMutableArray arrayWithArray:@[@"SXTMainViewController",@"SXTMeViewController"]];
    for (NSInteger i = 0; i < array.count; i ++) {
        NSString * vcName = array[i];
        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        SXTBaseNavViewController * nav = [[SXTBaseNavViewController alloc] initWithRootViewController:vc];
        [array replaceObjectAtIndex:i withObject:nav];
    }
    self.viewControllers = array;
}


- (void)tabbar:(SXTTabBar *)tabbar clickButton:(SXTItemType)idx
{
    if (idx != SXTItemTypeLanch) {
        self.selectedIndex = idx - SXTItemTypeLive;
        return;
    }
    
    //模态视图
    SXTLaunchViewController * launchVC = [[SXTLaunchViewController alloc] init];
    [self presentViewController:launchVC animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
