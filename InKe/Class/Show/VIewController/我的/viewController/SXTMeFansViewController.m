//
//  SXTMeFansViewController.m
//  InKe
//
//  Created by SJQ on 2018/4/16.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTMeFansViewController.h"
#import "SXTMeUserTableViewCell.h"
#import "SXTMiaoBoModel.h"

@interface SXTMeFansViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tabelView;

@end

@implementation SXTMeFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"粉丝列表";
    [self setupNav];
    [self setupDate];
    [self setupTableView];
}

- (void)setupNav {
    UIButton *leftButton = [FNButton commonNavBackButton];
    [leftButton addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)onBackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarWithType:FNNavationBarType_Normal];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)setupTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:(UITableViewStylePlain)];
    [self.view addSubview:_tabelView];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.tableFooterView = [[UIView alloc] init];
    [_tabelView registerNib:[UINib nibWithNibName:@"SXTMeUserTableViewCell" bundle:nil] forCellReuseIdentifier:@"SXTMeUserTableViewCell"];
}

- (void)setupDate {
    _dataSource = [[NSMutableArray alloc] init];
    SXTMiaoBoModel *model1 = [[SXTMiaoBoModel alloc] init];
    model1.smallpic = @"test_touxiang";
    model1.myname = @"好看哎";
    model1.sex = 0;
    model1.signatures = @"这是谁的世界？";
    [_dataSource addObject:model1];
    
    SXTMiaoBoModel *model2 = [[SXTMiaoBoModel alloc] init];
    model2.smallpic = @"test_touxiang";
    model2.myname = @"我是二号二号为何物";
    model2.sex = 1;
    model2.signatures = @"";
    [_dataSource addObject:model2];
    
    SXTMiaoBoModel *model3 = [[SXTMiaoBoModel alloc] init];
    model3.smallpic = @"test_touxiang";
    model3.myname = @"缘起缘灭";
    model3.sex = 1;
    model3.signatures = @"动乱";
    [_dataSource addObject:model3];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SXTMeUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SXTMeUserTableViewCell"];
    SXTMiaoBoModel *model = _dataSource[indexPath.row];
    cell.miaoModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
