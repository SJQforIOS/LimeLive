//
//  SXTHotViewController.m
//  InKe
//
//  Created by sjq on 17/8/28.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTHotViewController.h"
#import "SXTLiveHandler.h"
#import "SXTLiveCell.h"
#import "SXTCreator.h"
#import "SXTPlayViewController.h"
#import "SXTMiaoBoModel.h"

static NSString * identifier = @"SXTLiveCell";

@interface SXTHotViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<SXTMiaoBoModel *> * datalist;


@end

@implementation SXTHotViewController

- (NSMutableArray *)datalist {
    
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self initUI];
    
    [self.tableView.mj_header beginRefreshing];//进入就刷新
    //每20秒刷新一次
    [NSTimer scheduledTimerWithTimeInterval:20 block:^(NSTimer * _Nonnull timer) {
        [self loadData];
    } repeats:YES];
    
}

- (void)initUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXTLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    __weak id weakself = self;
    //下拉 上拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadArticleDataisRefresh:YES];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself loadArticleDataisRefresh:NO];
    }];
    
}

//有上拉刷新  YES
- (void)loadArticleDataisRefresh:(BOOL)isRefresh
{
    if (isRefresh) {
        NSLog(@"下拉刷新");
        [self loadData];
    } else {
        NSLog(@"上拉刷新");
        [self loadData];
    }
    
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];//闲置状态
}

- (void)loadData
{
    [SXTLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        //获取到数据
        self.datalist = obj;
        [self.tableView reloadData];
    } failed:^(id obj) {
        
    }];
}

#pragma UITableViewDelegate 实现协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXTLiveCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    SXTMiaoBoModel *miao = self.datalist[indexPath.row];
    [cell setViewForMiaoBo:miao];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70 + SCREEN_WIDTH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SXTMiaoBoModel *miao = self.datalist[indexPath.row];
    
    SXTPlayViewController *playVC = [[SXTPlayViewController alloc] init];
    playVC.miaoBoModel = miao;
    [self.navigationController pushViewController:playVC animated:YES];
    
    /*系统自带的播放器播放不了直播内容
     
     MPMoviePlayerViewController * movieVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:live.streamAddr]];
     
     [self presentViewController:movieVC animated:YES completion:nil];
     */
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
