//
//  YT_BaseTabBarMoreThanFive.m
//  CustomTabBarCotrollerTest
//
//  Created by 付宝网络 on 2018/2/23.
//  Copyright © 2018年 zy. All rights reserved.
//

#import "YT_BaseTabBarMoreThanFive.h"
#import "YTBaseNavigationController.h"
#import "YT_CustomTabBarView.h"
@interface YT_BaseTabBarMoreThanFive ()<YT_CustomTabBarViewDelegate>
@property (nonatomic, strong) YT_CustomTabBarView *customTabBar;
@end

@implementation YT_BaseTabBarMoreThanFive

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
    UIViewController *homeVC = [[UIViewController alloc] init];
    homeVC.view.backgroundColor = [UIColor redColor];
    [self addChildVC:homeVC title:@"首页" normalImageName:@"首页png" andSelectedImageName:@"首页dpng"];
    
    UIViewController *activityVC = [[UIViewController alloc] init];
    activityVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildVC:activityVC title:@"活动" normalImageName:@"购物车png" andSelectedImageName:@"购物车dpng"];
    
    UIViewController *findVC = [[UIViewController alloc] init];
    findVC.view.backgroundColor = [UIColor blueColor];
    [self addChildVC:findVC title:@"列表" normalImageName:@"我的png" andSelectedImageName:@"我的dpng"];
    
    
    UIViewController *homeVC2 = [[UIViewController alloc] init];
    homeVC2.view.backgroundColor = [UIColor redColor];
    [self addChildVC:homeVC2 title:@"首页" normalImageName:@"首页png" andSelectedImageName:@"首页dpng"];
    
    UIViewController *activityVC2 = [[UIViewController alloc] init];
    activityVC2.view.backgroundColor = [UIColor yellowColor];
    [self addChildVC:activityVC2 title:@"活动" normalImageName:@"购物车png" andSelectedImageName:@"购物车dpng"];
    
//    UIViewController *findVC2 = [[UIViewController alloc] init];
//    findVC2.view.backgroundColor = [UIColor blueColor];
//    [self addChildVC:findVC2 title:@"列表" normalImageName:@"我的png" andSelectedImageName:@"我的dpng"];
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
