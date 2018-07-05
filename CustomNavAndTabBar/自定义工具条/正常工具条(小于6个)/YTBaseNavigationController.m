//
//  YTBaseNavigationController.m
//  CustomNavAndTabBar
//
//  Created by yatao li on 2018/7/5.
//  Copyright © 2018年 李亚涛. All rights reserved.
//

#import "YTBaseNavigationController.h"

@interface YTBaseNavigationController ()

@end

@implementation YTBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.navigationBar.barTintColor = [UIColor orangeColor];
    //设置导航栏上左右按钮的颜色
    self.navigationBar.tintColor = [UIColor redColor];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //替换系统的返回按钮图片
    UIImage *image = [UIImage imageNamed:@"backArrow"];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorTransitionMaskImage = image;
    self.navigationBar.backIndicatorImage = image;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count == 1) {
        
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    [super pushViewController:viewController animated:animated];
    UIBarButtonItem *backIetm = [[UIBarButtonItem alloc] init];
    backIetm.title = @"";
    viewController.navigationItem.backBarButtonItem = backIetm;
}
@end
