//
//  YT_BaseTabBarMoreThanFive.m
//  CustomTabBarCotrollerTest
//
//  Created by 付宝网络 on 2018/2/23.
//  Copyright © 2018年 zy. All rights reserved.
//

#import "YT_BaseTabBarController.h"
#import "YTBaseNavigationController.h"
#import "YT_CustomTabBarView.h"

#import "HomeViewController.h"
#import "ShopCarViewController.h"
#import "MeViewController.h"
@interface YT_BaseTabBarController ()<YT_CustomTabBarViewDelegate>
@property (nonatomic, strong) YT_CustomTabBarView *customTabBar;
@end

@implementation YT_BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTabbar];
    [self addAllChildViewController];
}
- (void)setupTabbar
{
    self.customTabBar = [[YT_CustomTabBarView alloc] init];
    self.customTabBar.frame = self.tabBar.bounds;
    self.customTabBar.delegate = self;
    [self.tabBar addSubview:self.customTabBar];
}
- (void)tabBar:(YT_CustomTabBarView *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to{
    self.selectedIndex = to;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
}
#pragma mark - 添加全部的 childViewcontroller(常用的)
- (void)addAllChildViewController
{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self addChildVC:homeVC title:@"首页" normalImageName:@"首页png" andSelectedImageName:@"首页dpng"];
    
    ShopCarViewController *activityVC = [[ShopCarViewController alloc] init];
    [self addChildVC:activityVC title:@"活动" normalImageName:@"购物车png" andSelectedImageName:@"购物车dpng"];
    
    MeViewController *findVC = [[MeViewController alloc] init];
    [self addChildVC:findVC title:@"列表" normalImageName:@"我的png" andSelectedImageName:@"我的dpng"];
    
    
    HomeViewController *homeVC2 = [[HomeViewController alloc] init];
    homeVC2.view.backgroundColor = [UIColor redColor];
    [self addChildVC:homeVC2 title:@"首页" normalImageName:@"首页png" andSelectedImageName:@"首页dpng"];
    
    ShopCarViewController *activityVC2 = [[ShopCarViewController alloc] init];
    activityVC2.view.backgroundColor = [UIColor yellowColor];
    [self addChildVC:activityVC2 title:@"活动" normalImageName:@"购物车png" andSelectedImageName:@"购物车dpng"];
    
    MeViewController *findVC2 = [[MeViewController alloc] init];
    [self addChildVC:findVC2 title:@"列表" normalImageName:@"我的png" andSelectedImageName:@"我的dpng"];
}
#pragma mark - 添加某个 childViewController
- (void)addChildVC:(UIViewController *)vc title:(NSString *)title normalImageName:(NSString *)normalNamed andSelectedImageName:(NSString *)selecteName
{

    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:normalNamed];
    UIImage *selectedImage = [UIImage imageNamed:selecteName];
    vc.tabBarItem.selectedImage = selectedImage;
    
    
    //选中颜色和正常颜色在  YT_CustomTabBarButton.m 里边设置
    

    YTBaseNavigationController *nav = [[YTBaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    
    
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];
    
    

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
