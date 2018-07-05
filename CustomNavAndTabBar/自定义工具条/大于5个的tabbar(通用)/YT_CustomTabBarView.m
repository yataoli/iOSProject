//
//  YT_CustomTabBarView.m
//  CustomTabBarCotrollerTest
//
//  Created by 付宝网络 on 2018/2/23.
//  Copyright © 2018年 zy. All rights reserved.
//

#import "YT_CustomTabBarView.h"
#import "YT_CustomTabBarButton.h"
@interface YT_CustomTabBarView()
@property (nonatomic, weak) YT_CustomTabBarButton *selectedButton;
@end
@implementation YT_CustomTabBarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    
    YT_CustomTabBarButton *button = [[YT_CustomTabBarButton alloc] init];
    [self addSubview:button];
    button.item = item;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}
- (void)buttonClick:(YT_CustomTabBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonY = 0;
    for (int index = 0; index<self.subviews.count; index++) {
        YT_CustomTabBarButton *button = self.subviews[index];
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = index;
    }
}

@end
