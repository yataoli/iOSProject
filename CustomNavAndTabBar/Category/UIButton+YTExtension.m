//
//  UIButton+Category.m
//  CustomNavAndTabBar
//
//  Created by yatao li on 2018/5/10.
//  Copyright © 2018年 李亚涛. All rights reserved.
//

#import "UIButton+YTExtension.h"
@implementation UIButton (YTExtension)
//设置按钮的不同状态的背景颜色  让程序根据颜色自动生成不同的纯色背景图片即可。
- (void)setBackgroundColor:(nullable UIColor *)color forState:(ButtonState)state{
    if (state == 1) {
        [self setBackgroundImage:[UIButton imageWithColor:color] forState:UIControlStateSelected];
        
    }else{
        [self setBackgroundImage:[UIButton imageWithColor:color] forState:UIControlStateNormal];
        
    }

}
+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
}
@end
