//
//  UIButton+Category.h
//  CustomNavAndTabBar
//
//  Created by yatao li on 2018/5/10.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ButtonState){
    ButtonStateNormal = 0,
    ButtonStateSelected,
};
@interface UIButton (Category)
- (void)setBackgroundColor:(nullable UIColor *)color forState:(ButtonState)state;
@end

