//
//  SXTBaseViewController.m
//  InKe
//
//  Created by sjq on 17/8/28.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTBaseViewController.h"
#import <objc/runtime.h>

@interface SXTBaseViewController ()

@end

@implementation SXTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DDLogVerbose(@"viewWillAppear %@", self.class);
}



- (void)setNavigationBarWithType:(FNNavationBarType)type {
    UINavigationBar *navBar = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        navBar = [(UINavigationController *)self navigationBar];
    } else {
        navBar = self.navigationController.navigationBar;
    }
    
    
    if (type == FNNavationBarType_Green) {
        if (IOS10) {
            [navBar setHidden:NO];
        } else {
            [navBar setUserInteractionEnabled:YES];
        }
        self.navigationController.navigationBar.barTintColor = RGB(0, 216, 201);
        [self setBarTintColor:navBar color:[UIColor whiteColor]];
        [self.navigationItem setHidesBackButton:NO];
    } else if (type == FNNavationBarType_Normal) {
        if (IOS10) {
            [navBar setHidden:NO];
        } else {
            [navBar setUserInteractionEnabled:YES];
        }
        self.navigationController.navigationBar.barTintColor = RGB(255, 255, 255);
        [self setBarTintColor:navBar color:[UIColor blackColor]];
        [self.navigationItem setHidesBackButton:NO];
    } else {
        if (IOS10) {
            [navBar setHidden:YES];
        } else {
            [navBar setUserInteractionEnabled:NO];
        }
        [self lt_setBackgroundColor:[UIColor clearColor]];
        [self setBarTintColor:navBar color:[UIColor clearColor]];
        [self.navigationItem setHidesBackButton:YES];
    }
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarTintColor:backgroundColor];
}

- (void)setBarTintColor:(UINavigationBar *)navBar color:(UIColor *)color {
    [self setBarTintColor:navBar color:color titleColor:color];
}

- (void)setBarTintColor:(UINavigationBar *)navBar color:(UIColor *)color titleColor:(UIColor *)titleColor {
    [navBar setTintColor:color];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:titleColor, NSForegroundColorAttributeName, [UIFont systemFontOfSize:17], NSFontAttributeName, nil];
    [navBar setTitleTextAttributes:attributes];
    
    // 重设自定义标题
    UIView *titleView = self.navigationItem.titleView;
    if (titleView.subviews.count>0) {
        UILabel *titleLabel = [titleView.subviews firstObject];
        if ([titleLabel isKindOfClass:[UILabel class]]) {
            [titleLabel setTextColor:titleColor];
        }
    }
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
