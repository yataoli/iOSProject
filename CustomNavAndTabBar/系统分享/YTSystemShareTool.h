//
//  YTSystemShareTool.h
//  系统分享
//
//  Created by 付宝网络 on 2018/10/27.
//  Copyright © 2018年 李亚涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^ShareBlock) (BOOL success,NSString *activityType);

@interface YTSystemShareTool : NSObject
+ (void)shareWithTitle:(NSString *)title url:(NSString *)url image:(UIImage *)image viewController:(UIViewController *)controller AndShareBlock:(ShareBlock)shareBlock;
@end

NS_ASSUME_NONNULL_END
