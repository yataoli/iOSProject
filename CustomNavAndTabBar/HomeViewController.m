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
@property (nonatomic) NSInteger currentPage;
@property (nonatomic,strong) NSString *lastString;
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
    self.currentPage = 1;
    self.lastString = @"";
//    NSString *keyStr = @"钥匙串哈哈哈哈哈";
//    NSData *keyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    
//    [YTNetworkingTool GET:@"http://sangji.vip/sangjifile/testdata1?r=34" responeseType:1 parameters:nil success:^(id responseObject) {
//        NSData *tempdata = aesDecryptData(responseObject, keyData);
//        NSString *tempstring = [[NSString alloc] initWithData:tempdata encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",tempstring);
////        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
////        NSLog(@"%@",string);
////
////        [SaveAndReadFileAtSandbox saveDataToSandbox:responseObject WithFilenName:@"测试数据"];
//////
////        NSData *aesdata = aesEncryptData(responseObject, keyData);
////        NSData *tempdata = aesDecryptData(aesdata, keyData);
////        NSString *tempstring = [[NSString alloc] initWithData:tempdata encoding:NSUTF8StringEncoding];
//////
////        [SaveAndReadFileAtSandbox saveDataToSandbox:aesdata WithFilenName:@"测试数据1"];
//    } failure:^(NSError *error) {
//        NSLog(@"-----");
//    } responeseHeader:^(NSHTTPURLResponse *response) {
//
//    }];
    
    
    NSString *str = @"15346068899";
    
    NSLog(@"运营商类型 == %@",[str telNumberType]);
    
    
    [self createUI];
    
    self.collectionView.mj_header = [YT_MJRefreshGifHeader headerWithRefreshingBlock:^{
        NSLog(@"----gif-----");
        self.currentPage = 1;
        [self requestzhuanxiudata];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.collectionView.mj_header endRefreshing];
//
//
//        });
    }];

    
    self.collectionView.mj_footer = [YT_MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        NSLog(@"++++gif++++");
        self.currentPage ++;
        [self requestzhuanxiudata];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//
//
//        });
    }];
    
    NSDate *date = [NSDate date];
    NSLog(@"--%@",@([date isToday]));
    NSLog(@"--%@",@([date isThisYear]));
    
}
- (void)requestzhuanxiudata{
    [MBProgressHUD shouHUDWithStr:nil atView:self.view];
    NSString *keyStr = @"sangji&sengji&liyatao";
    NSData *keyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"action":@"list",@"appid":@"38",@"appostype":@"2",@"appversion":@"2.0",@"channel":@"appstore",@"homeType":@"6",@"idfa":@"CC4AFF81-921B-41AA-BBF8-48FF54D4BADC",@"model":@"imagessets",@"page":@(self.currentPage),@"paging":@"1",@"perPage":@"40",@"systemversion":@"12.2",@"t8t_device_id":@"26365E38-D25A-472F-BD7A-E4A8C67AFB1F",@"to8to_token":@"",@"uid":@"0",@"version":@"2.5"};
    [YTNetworkingTool setHttpHeaderFieldWithDic:@{@"Cookie":@"Hm_lpvt_dbdd94468cf0ef471455c47f380f58d2=1554878011; Hm_lvt_dbdd94468cf0ef471455c47f380f58d2=1554857167,1554861552,1554864307,1554878011; to8to_cook=OkOcClPzRWV8ZFJlCIF4Ag==; to8to_landpage=https%3A//m.to8to.com/sz/zb/index2.html%3Fptag%3D30141_2_12_344%26appversion%3D2.0%26uid%3D0%26channel%3Dappstore%26systemversion%3D12.2%26t8t_device_id%3D26365E38-D25A-472F-BD7A-E4A8C67AFB1F%26appostype%3D2%26version%3D2.5%26to8to_token%3D%26appid%3D38%26idfa%3DCC4AFF81-921B-41AA-BBF8-48FF54D4BADC; to8to_sourcepage=; to8to_wap_tcode=sz; to8to_wap_tname=%E6%B7%B1%E5%9C%B3; to8to_wap_townid=1130; to8tosessionid=s_d0426e6883db27f7eb5bf78745ecde56; to8to_landtime=1554857167; to8tocookieid=90414b11946363dd61c6b921d75bc187845050; uid=CgoKUVytPM1eag1tUCvmAg==; to8to_tcode=sz; to8to_tname=%E6%B7%B1%E5%9C%B3; to8to_townid=1130",@"User-Agent":@"BSSJAL/2.0.2 (iPhone; iOS 12.2; TO8TOAPP)"}];
    [YTNetworkingTool POST:@"http://mobileapi.to8to.com/smallapp.php" responeseType:1 parameters:dic success:^(id responseObject) {
        NSData *tempData = aesEncryptData(responseObject, keyData);
        NSData *tempdata = aesDecryptData(tempData, keyData);
        NSString *tempstring = [[NSString alloc] initWithData:tempdata encoding:NSUTF8StringEncoding];
        NSLog(@"%@",tempstring);
        
        NSString *fileName = [NSString stringWithFormat:@"homeDataPage=%@",@(self.currentPage)];
        [SaveAndReadFileAtSandbox saveDataToSandbox:tempData WithFilenName:fileName];
        [MBProgressHUD hiddenHUD];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD hiddenHUD];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } responeseHeader:nil];
    
//    [YTNetworkingTool GET:@"http://sangji.vip/sangjifile/testdata1?r=34" responeseType:1 parameters:nil success:^(id responseObject) {
//        NSData *tempdata = aesDecryptData(responseObject, keyData);
//        NSString *tempstring = [[NSString alloc] initWithData:tempdata encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",tempstring);
//        //        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        //        NSLog(@"%@",string);
//        //
//        //        [SaveAndReadFileAtSandbox saveDataToSandbox:responseObject WithFilenName:@"测试数据"];
//        ////
//        //        NSData *aesdata = aesEncryptData(responseObject, keyData);
//        //        NSData *tempdata = aesDecryptData(aesdata, keyData);
//        //        NSString *tempstring = [[NSString alloc] initWithData:tempdata encoding:NSUTF8StringEncoding];
//        ////
//        //        [SaveAndReadFileAtSandbox saveDataToSandbox:aesdata WithFilenName:@"测试数据1"];
//        [self.collectionView.mj_header endRefreshing];
//        [self.collectionView.mj_footer endRefreshing];
//    } failure:^(NSError *error) {
//        NSLog(@"-----");
//        [self.collectionView.mj_header endRefreshing];
//        [self.collectionView.mj_footer endRefreshing];
//    } responeseHeader:^(NSHTTPURLResponse *response) {
//
//    }];
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
