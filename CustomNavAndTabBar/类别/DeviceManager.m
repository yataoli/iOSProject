//
//  DeviceManager.m
//  MyCategory
//
//  Created by suge on 2017/7/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DeviceManager.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

// 下面是获取ip需要的头文件
#include <ifaddrs.h>
#include <sys/socket.h> // Per msqr
#import <sys/ioctl.h>
#include <net/if.h>
#import <arpa/inet.h>
#include <mach/mach.h> // 获取CPU信息所需要引入的头文件


@implementation DeviceManager
+ (instancetype)shareDeviceManager{
    static DeviceManager *device = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        device = [[DeviceManager alloc] init];
    });
    return device;
}


//获取设备型号
- (NSString*)getDeviceVersion{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"] || [platform isEqualToString:@"iPhone3,2"] || [platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"] || [platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"] || [platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"] || [platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPod Touch 6G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"] || [platform isEqualToString:@"iPad2,2"] || [platform isEqualToString:@"iPad2,3"] || [platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad3,1"] || [platform isEqualToString:@"iPad3,2"] || [platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"] || [platform isEqualToString:@"iPad3,5"] || [platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad6,11"] || [platform isEqualToString:@"iPad6,12"])    return @"iPad 5";
    
    
    if ([platform isEqualToString:@"iPad4,1"] || [platform isEqualToString:@"iPad4,2"] || [platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"] || [platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    
    if ([platform isEqualToString:@"iPad2,5"] || [platform isEqualToString:@"iPad2,6"] || [platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad4,4"] || [platform isEqualToString:@"iPad4,5"] || [platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,7"] || [platform isEqualToString:@"iPad4,8"] || [platform isEqualToString:@"iPad4,9"])   return @"iPad Mini 3G";
  
    if ([platform isEqualToString:@"iPad5,1"] || [platform isEqualToString:@"iPad5,2"])   return @"iPad Mini 4G";
    
    if ([platform isEqualToString:@"iPad6,3"] || [platform isEqualToString:@"iPad6,4"] )   return @"iPad Pro (9.7 inch)";
    //return @"iPad Pro (9.7 inch)"
    if ([platform isEqualToString:@"iPad6,7"] || [platform isEqualToString:@"iPad6,8"])   return @"iPad Pro (12.9 inch)";
    //return @"iPad Pro (12.9 inch)";
    
    if ([platform isEqualToString:@"iPad7,3"] || [platform isEqualToString:@"iPad7,4"]) return @"iPad Pro (10.5 inch)";
    //return @"iPad Pro (10.5 inch)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}
/**
 *获取系统版本号
 */
- (NSString *)getSystemVersion{
    return [UIDevice currentDevice].systemVersion;
}
/**
 *获取设备电池容量，单位 mA 毫安
 */
- (NSInteger)getBatteryCapacity {
    NSString *deviceVersion = [DeviceManager shareDeviceManager].getDeviceVersion;
   
    if ([deviceVersion isEqualToString:@"iPhone 2G"]){
        return 1400;
    }else if ([deviceVersion isEqualToString:@"iPhone 3G"]){
        return 1150;
    }else if ([deviceVersion isEqualToString:@"iPhone 3GS"]){
        return 1219;
    }else if ([deviceVersion isEqualToString:@"iPhone 4"]){
        return 1420;
    }else if ([deviceVersion isEqualToString:@"iPhone 4S"]){
        return 1430;
    }else if ([deviceVersion isEqualToString:@"iPhone 5"]){
        return 1440;
    }else if ([deviceVersion isEqualToString:@"iPhone 5C"]){
        return 1507;
    }else if ([deviceVersion isEqualToString:@"iPhone 5S"]){
        return 1570;
    }else if ([deviceVersion isEqualToString:@"iPhone 6"]){
        return 1810;
    }else if ([deviceVersion isEqualToString:@"iPhone 6 Plus"]){
        return 2915;
    }else if ([deviceVersion isEqualToString:@"iPhone 6S"]){
        return 1715;
    }else if ([deviceVersion isEqualToString:@"iPhone 6S Plus"]){
        return 2750;
    }else if ([deviceVersion isEqualToString:@"iPhone SE"]){
        return 1624;
    }else if ([deviceVersion isEqualToString:@"iPhone 7"]){
        return 1960;
    }else if ([deviceVersion isEqualToString:@"iPhone 7 Plus"]){
        return 2900;
    }else if ([deviceVersion isEqualToString:@"iPhone 8"]){
        return 1821;
    }else if ([deviceVersion isEqualToString:@"iPhone 8 Plus"]){
        return 2691;
    }else if ([deviceVersion isEqualToString:@"iPod Touch 1G"]){
        return 789;
    }else if ([deviceVersion isEqualToString:@"iPod Touch 2G"]){
        return 789;
    }else if ([deviceVersion isEqualToString:@"iPod Touch 3G"]){
        return 930;
    }else if ([deviceVersion isEqualToString:@"iPod Touch 5G"]){
        return 1030;
    }else if ([deviceVersion isEqualToString:@"iPod Touch 6G"]){
        return 1030;
    }else if ([deviceVersion isEqualToString:@"iPad 1G"]){
        return 6613;
    }else if ([deviceVersion isEqualToString:@"iPad 2"]){
        return 6930;
    }else if ([deviceVersion isEqualToString:@"iPad 3"]){
        return 11560;
    }else if ([deviceVersion isEqualToString:@"iPad 4"]){
        return 11560;
    }else if ([deviceVersion isEqualToString:@"iPad 5"]){
        return 8820;
    }else if ([deviceVersion isEqualToString:@"iPad Air"]){
        return 8827;
    }else if ([deviceVersion isEqualToString:@"iPad Air 2"]){
        return 7340;
    }else if ([deviceVersion isEqualToString:@"iPad Mini 1G"]){
        return 4440;
    }else if ([deviceVersion isEqualToString:@"iPad Mini 2G"]){
        return 6471;
    }else if ([deviceVersion isEqualToString:@"iPad Mini 3G"]){
        return 6471;
    }else if ([deviceVersion isEqualToString:@"iPad Mini 4G"]){
        return 5124;
    }else if ([deviceVersion isEqualToString:@"iPad Mini 4G"]){
        return 5124;
    }else if ([deviceVersion isEqualToString:@"iPad Pro (9.7 inch)"]){
        return 7306;
    }else if ([deviceVersion isEqualToString:@"iPad Pro (12.9 inch)"]){
        return 10307;
    }else{
        return 0;
    }
}
/**
 *获取设备IP地址
 */
- (NSString *)getDeviceIPAddresses{
    
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++) {
        if (ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}
/**
 *获取设备名字
 */
- (NSString *)getDeviceName{
    return [UIDevice currentDevice].name;
}
/**
 *获取磁盘总空间 
 */
- (double)getTotalDiskSpace{
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1.0;
    int64_t space = [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1.0;
    
    return space/1024/1024/1024.0;
}
/**
 获取磁盘已使用空间
 */
- (double)getUsedDiskSpace{
    double totalDisk = [self getTotalDiskSpace];
    double freeDisk = [self getFreeDiskSpace];
    if (totalDisk < 0.0 || freeDisk < 0.0) return -1.0;
    double usedDisk = totalDisk - freeDisk;
    if (usedDisk < 0.0) usedDisk = -1.0;
        
    return usedDisk;
}
- (double)getFreeDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1.0;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1.0;
    return space/1024/1024/1024.0;
}
/**
 获取总内存空间
 */
- (double)getTotalMemory{
    int64_t totalMemory = [[NSProcessInfo processInfo] physicalMemory];
    if (totalMemory < -1) totalMemory = -1.0;
    return totalMemory/1024/1024/1024.0;
}
/**
 *获取空闲的内存空间
 */
- (double)getFreeMemory{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.free_count * page_size /1024/1024/1024.0;
}
/**
 *获取正在使用的内存空间
 */
- (double)getUsedMemory{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return page_size * (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count) / 1024/1024/1024.0;
}
#pragma mark - 获取APP name
- (NSString *)getAppName{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleDisplayName"];
    return currentVersion;
}
#pragma mark - 获取APP 版本号
- (NSString *)getAppVersion{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}
#pragma mark - 获取APP 的icon图标name
- (NSString *)getAppIconName{
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    return icon;
    
}
@end










