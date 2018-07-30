//
//  DeviceManager.h
//  MyCategory
//
//  Created by suge on 2017/7/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YT_Device : NSObject

/**
 *获取设备型号
 */
+ (NSString*)getDeviceVersion;

/**
 *获取系统版本号
 */
+ (NSString *)getSystemVersion;

/**
 *获取设备电池容量，单位 mA 毫安
 */
+ (NSInteger)getBatteryCapacity;

/**
 *获取设备IP地址
 */
+ (NSString *)getDeviceIPAddresses;

/**
 *获取设备名字
 */
+ (NSString *)getDeviceName;

/**
 获取磁盘总空间
 */
+ (double)getTotalDiskSpace;

/**
 获取磁盘已使用空间
 */
+ (double)getUsedDiskSpace;

/**
 获取磁盘未使用的空间
 */
+ (double)getFreeDiskSpace;

/**
 获取总内存空间
 */
+ (double)getTotalMemory;

/**
 *获取空闲的内存空间
 */
+ (double)getFreeMemory;

/**
 *获取正在使用的内存空间
 */
+ (double)getUsedMemory;

/**
 * 获取APP name
 */
+ (NSString *)getAppName;

/**
 * 获取APP 版本号
 */
+ (NSString *)getAppVersion;

/**
 * 获取APP 的icon图标name
 */
+ (NSString *)getAppIconName;

@end
