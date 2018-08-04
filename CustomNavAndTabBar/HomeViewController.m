//
//  HomeViewController.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/7/28.
//  Copyright © 2017年 李亚涛. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomColletionView.h"
#import "SaveAndReadFileAtSandbox.h"
#import "YT_CheckVersionManager.h"

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height
@interface HomeViewController ()
@property (nonatomic,assign) GoodsListType showType;
@property (nonatomic,strong) CustomColletionView *collectionView;
@property (nonatomic,strong) UIButton *moveBtn;
@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
//    [[YT_CheckVersionManager checkVersionManager] checkAppStoreVersionWithAPPID:@"1367104970"];
    
    
    
    [YTNetworkingTool GET:@"http://lc-eznpj0ig.cn-n1.lcfile.com/i00rs1Oj6Pi1pGx0aojkN2B.txt" responeseType:1 parameters:nil success:^(id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray *tempArray = [string componentsSeparatedByString:@"|"];
        NSLog(@"%@",string);
    } failure:^(NSError *error) {
        
    } responeseHeader:^(NSHTTPURLResponse *response) {
        
    }];
    
    
    NSString *str = @"15346068899";
    
    NSLog(@"运营商类型 == %@",[str telNumberType]);
    
    
    [self createUI];
    
    self.collectionView.mj_header = [YT_MJRefreshGifHeader headerWithRefreshingBlock:^{
        NSLog(@"----gif-----");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_header endRefreshing];
            
            
        });
    }];

    
    self.collectionView.mj_footer = [YT_MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        NSLog(@"++++gif++++");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            
            
        });
    }];
    
    NSDate *date = [NSDate date];
    NSLog(@"--%@",@([date isToday]));
    NSLog(@"--%@",@([date isThisYear]));
    
}
- (void)buttonCodeButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    
}
- (void)createUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[CustomColletionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.showType = self.showType;
    
    
    //更换展示商品列表的按钮
    _moveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moveBtn.frame = CGRectMake(ScreenWidth - 30 - 10, 64 + 10, 30, 30);
    [_moveBtn addTarget:self action:@selector(changeShowTypeHome:) forControlEvents:UIControlEventTouchUpInside];
    [_moveBtn setBackgroundImage:[UIImage imageNamed:@"商品列表样式2"] forState:UIControlStateNormal];
    [_moveBtn setBackgroundImage:[UIImage imageNamed:@"商品列表样式1"] forState:UIControlStateSelected];
    [self.view addSubview:_moveBtn];
    
    /*
    [NetworkingManager GET:@"http://p71yuflyr.bkt.clouddn.com/GuideData.txt" responeseType:HttpResponseData parameters:nil successBlock:^(id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"请求成功 == %@",string);
    } failure:^(NSError *error) {
        NSLog(@"请求失败 error == %@",error.description);
    } sessionDataTask:^(NSURLSessionDataTask *task) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSLog(@"响应头内容 == %@",allHeaders);
    }];
    */
    /*
    [NetworkingManager POST:@"http://p71yuflyr.bkt.clouddn.com/GuideData.txt" responeseType:HttpResponseData parameters:nil successBlock:^(id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"请求成功 == %@",string);

    } failure:^(NSError *error) {
         NSLog(@"请求失败 error == %@",error.description);
    } sessionDataTask:^(NSURLSessionDataTask *task) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSLog(@"响应头内容 == %@",allHeaders);
    }];
    */
    

}
#pragma mark - 更改展示样式
-(void)changeShowTypeHome:(UIButton *)btn{
    
//    [YTInfoView showInfo:@"切换成功" onView:self];
    
    [YT_InfoView showInfo:@"切换成功" onView:self.view];
    
    
    if (btn.isSelected) {
        btn.selected = NO;
        self.collectionView.showType =singleLineShowOneGoods;
        
    } else {
        btn.selected = YES;
        self.collectionView.showType =singleLinShowDouleGoods;
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
