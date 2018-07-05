//
//  SaveFileToSandbox.h
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/2/10.
//  Copyright © 2018年 李亚涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveAndReadFileAtSandbox : NSObject
/**保存二进制数据到本地*/
+ (void)saveDataToSandbox:(NSData *)data;
/**读取二进制数据*/
+ (NSData *)readDataFromSandbox;
/**删除本地二进制数据*/
+ (BOOL)deleteDataAtSandbox;
@end

