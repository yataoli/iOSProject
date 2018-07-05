//
//  YT_InfoView.m
//  CustomNavAndTabBar
//
//  Created by yatao li on 2018/5/10.
//  Copyright © 2018年 李亚涛. All rights reserved.
//

#import "YT_InfoView.h"
@interface YT_InfoView()
@property (strong, nonatomic) UILabel *infoLabel;
@property (nonatomic) CGFloat textWith;
@end
@implementation YT_InfoView

- (instancetype)initwithInfo:(NSString *)info andView:(UIView *)view{
    if ([super init]) {
        
        //动态长度
        self.textWith = [self createSize:info andFont:18 andSize:CGSizeMake(SCREEN_WIDTH, 30)andName:nil].size.width;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        self.layer.cornerRadius = 4.0;
        self.layer.masksToBounds = YES;
        self.frame = CGRectMake((view.frame.size.width - self.textWith)/2.0, (view.frame.size.height - 30)/2.0, self.textWith, 30);
        self.infoLabel = [[UILabel alloc] init];
        self.infoLabel.frame = CGRectMake(0, 0, self.textWith, self.frame.size.height);
        self.infoLabel.numberOfLines = 0;
        self.infoLabel.textAlignment = 1;
        self.infoLabel.font = [UIFont systemFontOfSize:15.0];
        self.infoLabel.textColor = [UIColor whiteColor];
        self.infoLabel.font = [UIFont systemFontOfSize:15.0];
        self.infoLabel.text = info;
        
        
        
        [self addSubview:self.infoLabel];
        
        
    }
    return self;
}

+ (void)showInfo:(NSString *)info onView:(UIView *)view{
    //动态长度
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新UI
        YT_InfoView *infoView = [[YT_InfoView alloc] initwithInfo:info andView:view];
        
        [view addSubview:infoView];
        [view bringSubviewToFront:infoView];
        [self countDown:1.0 dimissView:infoView];
    });
    
    
}
+ (void)countDown:(double)duration dimissView:(UIView *)view {
    NSTimer *timer = [NSTimer timerWithTimeInterval:duration target:view selector:@selector(dismiss) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)dismiss
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished)
     {
         self.infoLabel = nil;
         [self removeFromSuperview];
     }];
}

- (CGRect)createSize:(NSString *)lableStr andFont:(NSInteger)fondS andSize:(CGSize)mysize andName:(NSString *)name;
{
    UIFont *font;
    if (name.length == 0)
    {
        font=[UIFont systemFontOfSize:fondS];
    }else
    {
        font=[UIFont fontWithName:name size:fondS];
    }
    CGRect rect=[lableStr boundingRectWithSize:mysize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    return rect;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
