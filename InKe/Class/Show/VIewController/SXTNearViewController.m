//
//  SXTNearViewController.m
//  InKe
//
//  Created by sjq on 17/8/28.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTNearViewController.h"
#import "SXTLiveHandler.h"
#import "SXTCreator.h"
#import "SXTPlayViewController.h"
#import "SXTMiaoBoModel.h"
#import "SXTNearLiveCollectionViewCell.h"
#import "SXTNearPlayViewController.h"

#define kMargin 5
#define kItemWidth 100

@interface SXTNearViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UICollectionView *collectView;

@end

@implementation SXTNearViewController

- (NSMutableArray *)datasource {
    
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化数据
    [self setupUIView];
}

- (void)setupUIView {
    NSInteger count = SCREEN_WIDTH / kItemWidth;
    CGFloat etraWidth = (SCREEN_WIDTH - kMargin * (count + 1)) / count;
    
    UICollectionViewFlowLayout *shareflowLayout = [[UICollectionViewFlowLayout alloc] init];
    shareflowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    shareflowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    shareflowLayout.minimumLineSpacing = 5;
    shareflowLayout.minimumInteritemSpacing = 5;
    shareflowLayout.itemSize =CGSizeMake(etraWidth, etraWidth + 20);
    
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:shareflowLayout];
    _collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectView];
    _collectView.delaysContentTouches = NO;
    _collectView.delegate = self;
    _collectView.dataSource = self;
    [self.collectView registerNib:[UINib nibWithNibName:@"SXTNearLiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SXTNearLiveCollectionViewCell"];
    
    __weak typeof(self) weakSelf = self;
    // 设置header和footer
    self.collectView.mj_header = [ALinRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf loadArticleDataisRefresh];
    }];
    self.collectView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf loadArticleDataisRefresh];
    }];
    [self.collectView.mj_header beginRefreshing];
}

//有上拉刷新  YES
- (void)loadArticleDataisRefresh {
    __weak typeof(self) weakSelf = self;
    [SXTLiveHandler executeGetNearLiveTaskWithSuccess:self.currentPage and:^(id obj) {
        [weakSelf.collectView.mj_header endRefreshing];
        [weakSelf.collectView.mj_footer endRefreshing];
        if (weakSelf.datasource.count == 0) {
            weakSelf.datasource = obj;
        } else {
            [weakSelf.datasource addObjectsFromArray:obj];
        }
        [weakSelf.collectView reloadData];
    } failed:^(id obj) {
        [weakSelf.collectView.mj_header endRefreshing];
        [weakSelf.collectView.mj_footer endRefreshing];
        weakSelf.currentPage--;
        [weakSelf showHint:@"网络异常"];
    }];
}

#pragma mark - UICollectionViewDelegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SXTNearLiveCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SXTNearLiveCollectionViewCell" forIndexPath:indexPath];
    SXTNearModel *miao = self.datasource[indexPath.row];
    [cell setViewForMiaoBo:miao];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SXTNearModel *nearModel = self.datasource[indexPath.row];
    SXTNearPlayViewController *playVC = [[SXTNearPlayViewController alloc] init];
    playVC.nearModel = nearModel;
    [self.navigationController pushViewController:playVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
