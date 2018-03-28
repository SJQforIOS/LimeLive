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
@property (nonatomic, assign) NSInteger currentPage;

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
    
    //每20秒刷新一次
    __weak typeof(self) weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:20 block:^(NSTimer * _Nonnull timer) {
        [weakSelf loadData];
    } repeats:YES];
    
}

- (void)initUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXTLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    // 设置header和footer
    self.tableView.mj_header = [ALinRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf loadArticleDataisRefresh];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf loadArticleDataisRefresh];
    }];
    [self.tableView.mj_header beginRefreshing];
}

//有上拉刷新  YES
- (void)loadArticleDataisRefresh {
    //有上拉刷新  YES
    __weak typeof(self) weakSelf = self;
    [SXTLiveHandler executeGetHotLiveTaskWithSuccess:self.currentPage and:^(id obj) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (weakSelf.datalist.count == 0) {
            weakSelf.datalist = obj;
        } else {
            [weakSelf.datalist addObjectsFromArray:obj];
        }
        [weakSelf.tableView reloadData];
    } failed:^(id obj) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        weakSelf.currentPage--;
        [weakSelf showHint:@"网络异常"];
    }];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [SXTLiveHandler executeGetHotLiveTaskWithSuccess:1 and:^(id obj) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        weakSelf.datalist = obj;
        [weakSelf.tableView reloadData];
    } failed:^(id obj) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        weakSelf.currentPage--;
        [weakSelf showHint:@"网络异常"];
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
