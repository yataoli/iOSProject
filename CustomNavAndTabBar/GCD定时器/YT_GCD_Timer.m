//
//  YT_GCD_Timer.m
//  GCDProject
//
//  Created by 付宝网络 on 2018/5/19.
//  Copyright © 2018年 liyatao. All rights reserved.
//

#import "YT_GCD_Timer.h"
@interface YT_GCD_Timer ()
@property  NSTimeInterval time;
@property (nullable,weak) id atarget;
@property (nullable,nonatomic, assign) SEL aSelector;
@property (nonatomic, strong) dispatch_source_t timer;
@end
@implementation YT_GCD_Timer

- (id)init
{
    self = [super init];
    
    return self;
}
+ (YT_GCD_Timer *)initTimerWithTimeInterval:(NSTimeInterval )time target:(nonnull id)aTarget selector:(nonnull SEL)aSelector{
    YT_GCD_Timer *timer = [[YT_GCD_Timer alloc] init];
    timer.time = time;
    timer.atarget = aTarget;
    timer.aSelector = aSelector;
    [timer createGCDTimer];
    return timer;
}
- (void)createGCDTimer{
    
    // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, self.time * NSEC_PER_SEC, 0);
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        
        [self.atarget performSelectorOnMainThread:self.aSelector withObject:nil waitUntilDone:NO];
    });
}
#pragma mark - 立即开始
- (void)fireTimer{
    if (self.timer) {
        dispatch_resume(self.timer);
    }
   
}
#pragma mark -  在 多少秒 后开启
- (void)fireTierAfter:(NSTimeInterval)second{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_resume(self.timer);
    });
}
#pragma mark - 暂停
- (void)pauseTimer{
    if (self.timer) {
        dispatch_suspend(self.timer);
    }
    
}
#pragma mark - 停止（销毁）
- (void)stopTimer{
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    
}
@end
