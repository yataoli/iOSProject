//
//  YT_GCD_Timer.h
//  GCDProject
//
//  Created by 付宝网络 on 2018/5/19.
//  Copyright © 2018年 liyatao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YT_GCD_Timer : NSObject

+ (YT_GCD_Timer *)initTimerWithTimeInterval:(NSTimeInterval )time target:(nonnull id)aTarget selector:(nonnull SEL)aSelector;
/**
 * 立即开启 定时器
 */
- (void)fireTimer;
/**
 * 在 多少 秒 后开启
 */
- (void)fireTierAfter:(NSTimeInterval)second;
/**
 * 暂停 定时器
 */
- (void)pauseTimer;
/**
 *停止（销毁） 定时器
 */
- (void)stopTimer;
@end
