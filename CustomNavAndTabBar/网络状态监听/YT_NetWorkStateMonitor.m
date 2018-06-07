//
//  YTNetWorkState.m
//  顶部提示
//
//  Created by suge on 2017/6/14.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import "YT_NetWorkStateMonitor.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCellularData.h>
static YT_NetWorkStateMonitor *netWorkState = nil;

@implementation YT_NetWorkStateMonitor

+ (YT_NetWorkStateMonitor *)shareNetWorkStateMonitor{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkState = [[YT_NetWorkStateMonitor alloc] init];
        
    });
    return netWorkState;
}
#pragma mark - 获取当前网络类型
- (NSString *)getNetWorkType{
    
    NSString *netWorkType;
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus state = [conn currentReachabilityStatus];
    if (state == ReachableViaWWAN) {
        // 没有使用wifi, 使用手机自带网络进行上网
        netWorkType = [self getNetType];
        
    }else if (state == ReachableViaWiFi) {
        // 有wifi
        netWorkType = @"wifi";
    }else{
        // 没有网络
        netWorkType = @"NO";
        
    }
    NSLog(@"当前网络类型 == %@",netWorkType)
    
    return netWorkType;
}
// 添加网络监听
- (void)addNetWorkStateMonitor{
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChanged:) name:kReachabilityChangedNotification object:nil];
}

#pragma mark - 触发时机，网络状态发生改变
- (void)netWorkStateChanged:(NSNotification *)notification{
   Reachability *conn = (Reachability *)notification.object;
    NetworkStatus state = [conn currentReachabilityStatus];
    NSString *netWorkType;
    if (state == ReachableViaWWAN) {
        // 没有使用wifi, 使用手机自带网络进行上网
        netWorkType = [self getNetType];
        
    }else if (state == ReachableViaWiFi) {
        // 有wifi
        netWorkType = @"wifi";
    }else{
        // 没有网络
        netWorkType = @"NO";
        
    }
    NSLog(@"切换后的网络类型 == %@",netWorkType);
    if (self.delegate && [self.delegate respondsToSelector:@selector(netWorkStateChangedWithType:)]) {
        [self.delegate netWorkStateChangedWithType:netWorkType];
        
    }
}
#pragma mark - 获取手机网络类型
- (NSString *)getNetType
{
    
    NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                               CTRadioAccessTechnologyGPRS,
                               CTRadioAccessTechnologyCDMA1x];
    
    NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                               CTRadioAccessTechnologyWCDMA,
                               CTRadioAccessTechnologyHSUPA,
                               CTRadioAccessTechnologyCDMAEVDORev0,
                               CTRadioAccessTechnologyCDMAEVDORevA,
                               CTRadioAccessTechnologyCDMAEVDORevB,
                               CTRadioAccessTechnologyeHRPD];
    
    NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
    NSString *netconnType;
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentStatus = info.currentRadioAccessTechnology;
    
    if ([typeStrings4G containsObject:currentStatus]) {
        netconnType = @"4G";
    } else if ([typeStrings3G containsObject:currentStatus]) {
        netconnType = @"3G";
    } else if ([typeStrings2G containsObject:currentStatus]) {
        netconnType = @"2G";
       
    }else {
        //未知网络
        netconnType = nil;
    }
    return netconnType;

}
- (NSString *)checkNetWorkAuthor{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        __block NSString *messageStr = @"";
        CTCellularData *cellularData = [[CTCellularData alloc] init];
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *str1 = @"WiFi或蜂窝网络已经断开";
                NSString *str2 = @"\n请检查您的网络设置";
                NSString *str3 = @"";
                NSString *str4 = @"";
                if (cellularData.restrictedState == kCTCellularDataRestricted) {
                    str1 = @"系统已为此应用关闭无线局域网";
                    str2 = @"\n您可以在“";
                    str3 = @"设置";
                    str4 = @"”中为此应用打开无线局域网";
                }
                messageStr  = [NSString stringWithFormat:@"%@%@%@%@",str1,str2,str3,str4];
                
            });
        };
        return messageStr;
    }else{
        return @"当前网络不可用,请检查您的网络设置";
    }
    
}


@end
