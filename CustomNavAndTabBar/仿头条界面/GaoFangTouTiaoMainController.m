//
//  GaoFangTouTiaoMainController.m
//  CustomNavAndTabBar
//
//  Created by yatao li on 2018/7/3.
//  Copyright © 2018年 李亚涛. All rights reserved.
//

#import "GaoFangTouTiaoMainController.h"
#import "GaoFangTouTiaoTestContenVC.h"
#import "SGPagingView.h"
@interface GaoFangTouTiaoMainController ()<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@property (nonatomic, assign) BOOL isPushNextVC;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation GaoFangTouTiaoMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self customNav];
    
    [MBProgressHUD shouHUDWithStr:nil atView:self.view];
    NSString * url = [NSString stringWithFormat:@"http://admin.whjunqi.com:85/index.php/Home/Port/caizhong/user/yirenchat?r=%@",@(arc4random() % 100)];
    [NetworkingManager GET:url responeseType:1 parameters:nil successBlock:^(id responseObject) {
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray *tempArray = [str componentsSeparatedByString:@"^"];
        for (NSString *string in tempArray) {
            NSArray *smallArray = [string componentsSeparatedByString:@","];
            [self.dataArray addObject:smallArray[0]];
        }
        [self setupNavigationBar];
        [MBProgressHUD hiddenHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hiddenHUD];
    } sessionDataTask:^(NSURLSessionDataTask *task) {
        NSHTTPURLResponse *respose = (NSHTTPURLResponse *)task.response;
        NSLog(@"code == %ld \n %@",(long)respose.statusCode,respose.allHeaderFields);
        
    }];
    
}
- (void)customNav{
    CGFloat btnWidth = 50,btnHeight = 40;
    
    //     更多
    UIView *view_right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnWidth*1, btnHeight)];
    UIButton *button_rightOne = [UIButton buttonWithType:UIButtonTypeCustom];
    button_rightOne.frame = CGRectMake(0, 0, btnWidth, btnHeight);
    [button_rightOne setBackgroundColor:[UIColor blackColor]];

    [button_rightOne setImage:[UIImage imageNamed:@"add_more_btn"] forState:0];
    button_rightOne.titleLabel.font = [UIFont systemFontOfSize:13];
    [button_rightOne setTitleColor:[UIColor redColor] forState:0];
    [button_rightOne setTitle:@"更多" forState:0];
    [view_right addSubview:button_rightOne];
    
    UIBarButtonItem *rightOneItem = [[UIBarButtonItem alloc] initWithCustomView:view_right];
    self.navigationItem.rightBarButtonItem = rightOneItem;
    
    
}
#pragma mark - 初始化导航栏的菜单栏
- (void)setupNavigationBar {
//    NSArray *titleArr = @[@"精选", @"电影", @"电视剧情", @"综艺", @"NBA", @"娱乐", @"动漫", @"演唱会", @"VIP会员"];
//    NSArray *titleArr = @[@"精选", @"电影", @"电视剧情", @"综艺"];
    NSArray *titleArr = self.dataArray;

    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleTextZoom = YES;
    configure.titleTextScaling = 0.3;
//    configure.spacingBetweenButtons = 0.0;
    // pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 44 * 3, 44) delegate:self titleNames:titleArr configure:configure];
    _pageTitleView.backgroundColor = [UIColor clearColor];

    self.navigationItem.titleView = _pageTitleView;
 
    
    NSMutableArray *childArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < titleArr.count; i ++) {
        GaoFangTouTiaoTestContenVC *vc = [[GaoFangTouTiaoTestContenVC alloc] init];
        vc.index = i;
        [childArr addObject:vc];
    }

    /// pageContentCollectionView
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - 64;
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}
#pragma mark - 标题按钮的点击事件切换界面
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}
#pragma mark - 滑动结束时间代理
- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


@end
