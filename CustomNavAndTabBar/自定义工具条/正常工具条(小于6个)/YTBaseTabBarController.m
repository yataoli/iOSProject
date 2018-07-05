//
//  YTBaseTabBarController.m
//  CustomNavAndTabBar
//
//  Created by yatao li on 2018/7/5.
//  Copyright © 2018年 李亚涛. All rights reserved.
//

#import "YTBaseTabBarController.h"
#import "YTBaseNavigationController.h"

#import "HomeViewController.h"
#import "ShopCarViewController.h"
#import "MeViewController.h"

@interface YTBaseTabBarController ()

@end

@implementation YTBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //首页
    HomeViewController *homeView =[[HomeViewController alloc] init];
    [self addChildVC:homeView tabBarItemTitle:@"首页" navigationItemTitle:@"首页" normalImageName:@"首页png" selectedImageName:@"首页dpng"];
    
    
    //购物车
    ShopCarViewController *shopView =[[ShopCarViewController alloc] init];
    [self addChildVC:shopView tabBarItemTitle:@"购物车" navigationItemTitle:@"购物车" normalImageName:@"购物车png" selectedImageName:@"购物车dpng"];
    
    
    //我的
    MeViewController *meView =[[MeViewController alloc] init];
    [self addChildVC:meView tabBarItemTitle:@"我的" navigationItemTitle:@"我的" normalImageName:@"我的png" selectedImageName:@"我的dpng"];
    
    [self setupTabBarView];
}
#pragma mark - 自定义tabBarView
- (void)setupTabBarView{
    UIView *barView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    barView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:barView atIndex:0];
    self.tabBar.opaque = YES;
}
#pragma mark - 添加某个 childViewController
- (void)addChildVC:(UIViewController *)vc tabBarItemTitle:(NSString *)tabBartitle navigationItemTitle:(NSString *)navigationTitle normalImageName:(NSString *)normalNamed selectedImageName:(NSString *)selecteName{
    YTBaseNavigationController *navigation = [[YTBaseNavigationController alloc] initWithRootViewController:vc];
    UIImage *selectedImage =[[UIImage imageNamed:selecteName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item =[[UITabBarItem alloc]initWithTitle:tabBartitle image:[[UIImage imageNamed:normalNamed]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:selectedImage];
    navigation.tabBarItem = item;
    //字体的正常颜色
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    //字体的选中颜色
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    vc.navigationItem.title = navigationTitle;
    [self addChildViewController:navigation];
}

@end
