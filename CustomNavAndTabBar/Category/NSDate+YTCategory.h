//
//  NSDate+YTCategory.h
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/7/30.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YTCategory)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

/**
 * 获取当前毫秒时间戳字符串
 */
+ (NSString *)getCurrentTimeIntervalString;

/**
 * 把指定时间(NSDate)转化为毫秒时间戳字符串
 */
- (NSString *)changeDateToTimeIntervalStr;

//+ (NSString *)getTimeIntervalWithDate:(NSDate *)date;


/**
 * 把指定时间(NSdate)转化为指定格式(yyyy-MM-dd HH:mm:ss)
 */
- (NSString *)changeDateToTimeStrWithFormat:(NSString *)format;

/**
 * 把时间戳(秒)字符串 转化为指定格式字符串(yyyy-MM-dd HH:mm)
 */
+ (NSString *)changeTimeIntervalStr:(NSString *)timeIntervalStr toTimeStrWithFormat:(NSString *)format;

/**
 * 把时间字符串(yyyy-MM-dd HH:mm:ss)转化为毫秒时间戳字符串
 */
+ (NSString *)changeTimeStrToTimeIntervalStrWithTimeStr:(NSString *)timeStr andTimeFormat:(NSString *)format;

/**
 *把时间字符串(yyyy-MM-dd HH:mm:ss)转化为刚刚、3分钟前、几小时前。
 */
+ (NSString *)changeTimeStr:(NSString *)timeStr toSecMinHoursDayWithFormatStr:(NSString *)format;

@end
