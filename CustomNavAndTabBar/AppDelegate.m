//
//  AppDelegate.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/7/28.
//  Copyright © 2017年 李亚涛. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "PushViewController.h"
#import "YT_GuidePageViewController.h"
#import "YT_NetWorkStateMonitor.h"
#import "YTAlertViewManager.h"


#import "YTBaseTabBarController.h"

#import "YT_BaseTabBarMoreThanFive.h"
@interface AppDelegate ()<UITabBarControllerDelegate,YT_GuidePageViewControllerDelegate,YTNetWorkStateMonitorDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"===%@",NSHomeDirectory());
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSString *urlString = @"baidu.com";
    BOOL isUrl = [urlString isUrlString];
    NSLog(@"isUrl == %@",@(isUrl));
    
    
    
    
    [YT_NetWorkStateMonitor shareNetWorkStateMonitor].delegate = self;
    [[YT_NetWorkStateMonitor shareNetWorkStateMonitor] addNetWorkStateMonitor];
    
    BOOL isFirstShow = [YT_GuidePageViewController isFirstShow];
//    isFirstShow = YES;
    if (isFirstShow == YES) {
        //显示引导页
        //存放图片的数组
//        NSArray *imageArray = @[@"1",@"3.jpeg",@"4.jpeg",@"5.jpeg"];
//        YT_GuidePageViewController *VC = [[YT_GuidePageViewController alloc] initWithImageNameArray:imageArray];
        
//        NSArray *imageArray = @[@"http://47.92.5.70/fz/img/q10.png",@"http://47.92.5.70/fz/img/q11.png",@"http://47.92.5.70/fz/img/q12.png",@"http://47.92.5.70/fz/img/q13.png"];
        YT_GuidePageViewController *VC = [[YT_GuidePageViewController alloc] initWithImageArray:Guide_imagesArray];

        VC.delegate = self;
        //设置pageControl的颜色 默认为浅白色和白色
        VC.pageControlNomalAndSelecteColorArray = @[[UIColor lightGrayColor],[UIColor redColor]];
        //设置前边几页是否显示跳过按钮  默认不展示
        //VC.everyPageShowEnterBtn = NO;
        self.window.rootViewController = VC;
        NSLog(@"进入引导页");
        
    }else{
        //进入主页
        NSLog(@"直接进入主页");
        [self enterViewController];
    }
    [self.window makeKeyAndVisible];
    
    if ([[[YT_NetWorkStateMonitor shareNetWorkStateMonitor] getNetWorkType] isEqualToString:@"NO"]) {
        [[YTAlertViewManager shareManager] showWithType:AlertViewTypeNoNetwork];
    }


    
    return YES;
}
- (void)enterViewController{
    /* 带突出按钮的tabbar
    BaseTabBarController *baseBar = [[BaseTabBarController alloc] init];
    baseBar.delegate = self;
    self.window.rootViewController = baseBar;
    */
    
//    YTBaseTabBarController *baseBar = [[YTBaseTabBarController alloc] init];
//    self.window.rootViewController = baseBar;
    
    
    
    YT_BaseTabBarMoreThanFive *baseBar = [[YT_BaseTabBarMoreThanFive alloc] init];
    self.window.rootViewController = baseBar;
    

}
#pragma mark - 网络类型切换监听
- (void)netWorkStateChangedWithType:(NSString *)type{
    if ([type isEqualToString:@"NO"]) {
        [[YTAlertViewManager shareManager] showWithType:AlertViewTypeNoNetwork];
    }else{
        
        [[YTAlertViewManager shareManager] showWithType:AlertViewTypeSuccess];
        [YTAlertViewManager shareManager].topTxt = type;
//        [YTAlertViewManager shareManager].lefImageName = @"post_animate_add";
        [[YTAlertViewManager shareManager] dismissAfterTime:3];
        
    }
    
    
}
#pragma mark - 将要选中tabBar上按钮的时候会调用这个协议方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if ([tabBarController.viewControllers indexOfObject:viewController] == 1) {
        PushViewController *pushVC = [[PushViewController alloc] init];
        pushVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [tabBarController presentViewController:pushVC animated:NO completion:nil];
        return NO;

    }else{
        return YES;
    }
    
    
}




@end
