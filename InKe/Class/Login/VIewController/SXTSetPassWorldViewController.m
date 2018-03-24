//
//  SXTSetPassWorldViewController.m
//  InKe
//
//  Created by SJQ on 2018/3/24.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTSetPassWorldViewController.h"
#import "SXTTabBarViewController.h"

@interface SXTSetPassWorldViewController ()

@property (weak, nonatomic) IBOutlet UITextField *uPassworldLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@end

@implementation SXTSetPassWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)nextAction:(id)sender {
    if (self.uPassworldLabel.text.length == 0) {
        [self.view makeToast:@"密码不能为空！" duration:1 position:CSToastPositionCenter];
    } else {
        //直接登陆
        [self showHint:@"登录成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.view.window.rootViewController = [[SXTTabBarViewController alloc] init];
        });
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
