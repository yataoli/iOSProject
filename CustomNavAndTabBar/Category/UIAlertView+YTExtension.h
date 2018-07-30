//
//  UIAlertView+YTExtension.h
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/7/30.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DismissBlock)(NSInteger buttonIndex);
typedef void (^CancelBlock)(void);

@interface UIAlertView (YTExtension)

+ (UIAlertView *)showAlertViewWithTitle:(NSString*) title message:(NSString*) message cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSArray*)otherButtons onDismiss:(DismissBlock)dismissed onCancel:(CancelBlock) cancelled;

@end
