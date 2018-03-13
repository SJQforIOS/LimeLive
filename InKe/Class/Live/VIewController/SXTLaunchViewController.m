//
//  SXTLaunchViewController.m
//  InKe
//
//  Created by sjq on 17/8/28.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTLaunchViewController.h"
#import "LFLivePreview.h"

@interface SXTLaunchViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *startLiveBtn;

@end

@implementation SXTLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bgImageView.image = [UIImage imageNamed:@"bg_zbfx"];
}

- (IBAction)closeLanch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionStartBtn:(UIButton *)sender {
    //开始直播
    UIView * backview = [[UIView alloc] initWithFrame:self.view.bounds];
    backview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backview];
    
    LFLivePreview * preView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    preView.vc = self;
    [self.view addSubview:preView];
    //开启直播
    //[preView startLive];
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
