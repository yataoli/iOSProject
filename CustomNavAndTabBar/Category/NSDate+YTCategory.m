//
//  NSDate+YTCategory.m
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/7/30.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "NSDate+YTCategory.h"

@implementation NSDate (YTCategory)
- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

#pragma mark - 获取当前毫秒时间戳字符串
+ (NSString *)getCurrentTimeIntervalString{
    NSDate *date = [NSDate date];
    NSString *timeInterval = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]*1000];
    return timeInterval;
}
#pragma mark - 把指定时间(NSDate)转化为毫秒时间戳字符串
- (NSString *)changeDateToTimeIntervalStr{
    NSString *timeInterval = [NSString stringWithFormat:@"%.0f",[self timeIntervalSince1970]*1000];
    return timeInterval;
}
//+ (NSString *)getTimeIntervalStrWithDate:(NSDate *)date{
//    NSString *timeInterval = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]*1000];
//    return timeInterval;
//}

#pragma mark - 把指定时间(NSdate)转化为指定格式 （yyyy-MM-dd HH:mm:ss）
- (NSString *)changeDateToTimeStrWithFormat:(NSString *)format{
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:format];
    NSString *str =[objDateformat stringFromDate:self];
    return str;
}

#pragma mark - 把时间戳(秒)字符串 转化为指定格式字符串 （yyyy-MM-dd HH:mm）
+ (NSString *)changeTimeIntervalStr:(NSString *)timeIntervalStr toTimeStrWithFormat:(NSString *)format{
    NSDateFormatter * dateFormater = [NSDateFormatter new];
    //    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormater setDateFormat:format];
    NSDate * confirmDate = [NSDate dateWithTimeIntervalSince1970:[timeIntervalStr integerValue]];
    NSString * myString = [dateFormater stringFromDate:confirmDate];
    return myString;
}

#pragma mark - 把时间字符串(yyyy-MM-dd HH:mm:ss)转化为毫秒时间戳字符串
+ (NSString *)changeTimeStrToTimeIntervalStrWithTimeStr:(NSString *)timeStr andTimeFormat:(NSString *)format{

    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    NSString *formaterStr = format;
    
    formater.dateFormat = formaterStr;
    
    NSDate *houTaiDate = [formater dateFromString:timeStr];
    
    NSString *timeInterval = [NSString stringWithFormat:@"%@",@([houTaiDate timeIntervalSince1970] * 1000)];
    return timeInterval;
}

#pragma mark - 把时间字符串(yyyy-MM-dd HH:mm:ss)转化为刚刚、3分钟前、几小时前。
+ (NSString *)changeTimeStr:(NSString *)timeStr toSecMinHoursDayWithFormatStr:(NSString *)format{
    NSString *dateStr = @"";
    //创建时间格式器，并设置时间格式
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    NSString *formaterStr = format;
    //     NSString *formaterStr = @"yyyy-MM-dd HH:mm:ss EEEE";
    //yyyy-MM-dd HH:mm:ss EEEE
    formater.dateFormat = formaterStr;
    
    //用时间格式器把指定的时间字符串 转化为相应格式的时间
    NSDate *houTaiDate = [formater dateFromString:timeStr];
    
    //日历
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
    {
        NSDate *currentDate = [NSDate date];
        //判断后台返回时间和当前时间的时间差,单位是秒
        double tempTimeInterval = [currentDate timeIntervalSinceDate:houTaiDate];
        if (tempTimeInterval <= 86400){
            if(tempTimeInterval < 60){
                dateStr = @"刚刚";
            }else if ((tempTimeInterval/60.0 > 1) && (tempTimeInterval / 60.0 / 60.0 < 1)){
                dateStr = [NSString stringWithFormat:@"%d分钟前",(int)tempTimeInterval/60];
            }else{
                dateStr = [NSString stringWithFormat:@"%d小时前",(int)tempTimeInterval/60/60];
            }
            
        }else{
            //返回 年月日发布的
            formater.dateFormat = @"yyyy-MM-dd";
            
            dateStr = [formater stringFromDate:houTaiDate];
        }
        
    }else{
        //日历
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        //根据日历判断 后台返回时间是否是在今天
        if ([calendar isDateInToday:houTaiDate]){
            //返回今天什么时候发布的，比如3分钟前
            
            NSDate *currentDate = [NSDate date];
            
            //判断后台返回时间和当前时间的时间差,单位是秒
            double tempTimeInterval = [currentDate timeIntervalSinceDate:houTaiDate];
            //        tempTimeInterval -= 8 * 3600;
            
            if(tempTimeInterval < 60){
                dateStr = @"刚刚";
            }else if ((tempTimeInterval/60.0 > 1) && (tempTimeInterval / 60.0 / 60.0 < 1)){
                dateStr = [NSString stringWithFormat:@"%d分钟前",(int)tempTimeInterval/60];
            }else{
                dateStr = [NSString stringWithFormat:@"%d小时前",(int)tempTimeInterval/60/60];
            }
            
        }else{
            //返回 年月日发布的
            formater.dateFormat = @"yyyy-MM-dd";
            
            dateStr = [formater stringFromDate:houTaiDate];
        }
    }
    
    return dateStr;
}

@end
