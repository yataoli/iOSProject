//
//  YT_CustomTabBarView.h
//  CustomTabBarCotrollerTest
//
//  Created by 付宝网络 on 2018/2/23.
//  Copyright © 2018年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YT_CustomTabBarView;

@protocol YT_CustomTabBarViewDelegate <NSObject>

@optional
- (void)tabBar:(YT_CustomTabBarView *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

@end
@interface YT_CustomTabBarView : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<YT_CustomTabBarViewDelegate> delegate;
@end
