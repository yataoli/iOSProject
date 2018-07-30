//
//  UIAlertView+YTExtension.m
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/7/30.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "UIAlertView+YTExtension.h"

static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;

@implementation UIAlertView (YTExtension)
+ (UIAlertView *)showAlertViewWithTitle:(NSString*) title message:(NSString*) message cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSArray*)otherButtons onDismiss:(DismissBlock)dismissed onCancel:(CancelBlock) cancelled{
    
    _cancelBlock  = [cancelled copy];
    
    _dismissBlock  = [dismissed copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self self]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    for(NSString *buttonTitle in otherButtons)
    [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    return alert;
}

+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
    if(buttonIndex == [alertView cancelButtonIndex])
    {
        _cancelBlock();
    }
    else
    {
        _dismissBlock(buttonIndex - 1);
    }
}
@end
