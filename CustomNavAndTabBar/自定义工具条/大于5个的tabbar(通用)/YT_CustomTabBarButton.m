//
//  YT_CustomTabBarButton.m
//  CustomTabBarCotrollerTest
//
//  Created by 付宝网络 on 2018/2/23.
//  Copyright © 2018年 zy. All rights reserved.
//

#define YT_TabBarButtonImageRatio 0.6

#define  YT_TitleColorNor [UIColor grayColor]

#define  YT_TitleColorSel [UIColor redColor]

#import "YT_CustomTabBarButton.h"

@implementation YT_CustomTabBarButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:YT_TitleColorNor forState:UIControlStateNormal];
        [self setTitleColor:YT_TitleColorSel forState:UIControlStateSelected];
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * YT_TabBarButtonImageRatio;
    return CGRectMake(0, 5 + 3, imageW, imageH-5);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * YT_TabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY+3, titleW, titleH - 3);
}
- (void)setItem:(UITabBarItem *)item
{
    
    _item = item;//不能使用self.item = item (会循环引用导致崩溃)
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
}
- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
