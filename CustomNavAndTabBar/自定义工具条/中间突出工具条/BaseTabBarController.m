//
//  BaseTabBarController.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/7/28.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "BaseTabBarController.h"
#import "MyNavigationViewController.h"
#import "HomeViewController.h"
#import "ShopCarViewController.h"
#import "MeViewController.h"
#import "UIColor+HexRGB.h"

#import "MyTabBar.h"
#import "SkinManager.h"

@interface BaseTabBarController (){
    NSArray* _images;
    
    NSArray* _selectedImages;
    
    NSArray *_defaultImages;
    NSArray *_defaultSelectedImages;
}

@end

@implementation BaseTabBarController
- (void)viewDidLoad{
   [self createUI]; 
}
- (void)createUI{
    
    MyTabBar *tabBar = [[MyTabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
    tabBar.tintColor = [UIColor colorWithRed:251.0f / 255.0f green:132.0f / 255.0f blue:0.0f alpha:1.0f];
    [self setValue:tabBar forKey:@"tabBar"];
    
    
    
    
    //首页
    HomeViewController *homeView =[[HomeViewController alloc] init];
    [self addChildVC:homeView tabBarItemTitle:@"首页" navigationItemTitle:@"首页" normalImageName:@"首页png" selectedImageName:@"首页dpng"];
    
    
    //购物车
    ShopCarViewController *shopView =[[ShopCarViewController alloc] init];
     [self addChildVC:shopView tabBarItemTitle:@"购物车" navigationItemTitle:@"购物车" normalImageName:@"购物车png" selectedImageName:@"购物车dpng"];
    
    
    //我的
    MeViewController *meView =[[MeViewController alloc] init];
    [self addChildVC:meView tabBarItemTitle:@"我的" navigationItemTitle:@"我的" normalImageName:@"我的png" selectedImageName:@"我的dpng"];
    
    
    
    _images = @[@"tab_recent_nor.png", @"tab_buddy_nor.png", @"tab_qworld_nor.png"];
    
    _selectedImages = @[@"tab_recent_press.png", @"tab_buddy_press.png", @"tab_qworld_press.png"];
    _defaultImages = @[@"tabbar_home.png",@"tabbar_home.png",@"tab_buddy_nor.png"];
    _defaultSelectedImages = @[@"tabbar_home_selected.png",@"tabbar_home.png",@"tab_buddy_press.png"];
    [[SkinManager shareSkinManager] addObserver:self forKeyPath:@"currentSkin" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];
    
}

#pragma mark - 添加某个 childViewController
- (void)addChildVC:(UIViewController *)vc tabBarItemTitle:(NSString *)tabBartitle navigationItemTitle:(NSString *)navigationTitle normalImageName:(NSString *)normalNamed selectedImageName:(NSString *)selecteName{
     MyNavigationViewController *navigation = [[MyNavigationViewController alloc] initWithRootViewController:vc];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSString *currentSkin = change[@"new"];
    
    if ([currentSkin isEqualToString:@"00000"] ){
        return;
    }else{
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:currentSkin ofType:@"bundle"];
        NSString *tabBarBackgroundImagePath = [bundlePath stringByAppendingPathComponent:@"tabbar_bg_ios7.png"];
        self.tabBar.backgroundImage = [[UIImage alloc] initWithContentsOfFile:tabBarBackgroundImagePath];
        if ([currentSkin isEqualToString:@"1111"]){
            [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx != 1){
                    
                    obj.tabBarItem.image = [UIImage imageNamed:_defaultImages[idx]];
                    
                    obj.tabBarItem.selectedImage = [UIImage imageNamed:_defaultSelectedImages[idx]];
                }
                
            }];
        }else{
            [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx != 1)
                {
                    NSString *imagePath = [bundlePath stringByAppendingPathComponent:_images[idx]];
                    obj.tabBarItem.image = [[[UIImage alloc] initWithContentsOfFile:imagePath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    NSString *selectedPath = [bundlePath stringByAppendingPathComponent:_selectedImages[idx]];
                    obj.tabBarItem.selectedImage = [[[UIImage alloc] initWithContentsOfFile:selectedPath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                }
                
            }];
        }
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
