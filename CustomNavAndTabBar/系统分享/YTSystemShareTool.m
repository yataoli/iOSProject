//
//  YTSystemShareTool.m
//  系统分享
//
//  Created by 付宝网络 on 2018/10/27.
//  Copyright © 2018年 李亚涛. All rights reserved.
//

#import "YTSystemShareTool.h"

@implementation YTSystemShareTool
+ (void)shareWithTitle:(NSString *)title url:(NSString *)url image:(UIImage *)image viewController:(UIViewController *)controller AndShareBlock:(ShareBlock)shareBlock{
    title = title.length > 0 ? title : @"";
    url = url.length > 0 ? url : @"";
    if (!image) {
        image = [UIImage imageNamed:@""];
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    NSURL *urlToShare = [NSURL URLWithString:url];
    NSArray *activityItems = @[imageData,title,urlToShare];
    UIActivityViewController * activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        if (shareBlock) {
            shareBlock(completed,activityType);
        }
        [activityVC dismissViewControllerAnimated:YES completion:nil];
    };
    activityVC.completionWithItemsHandler = myBlock;
    
    //数组里边是被排除的分享方式
    activityVC.excludedActivityTypes = @[UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypeAssignToContact,UIActivityTypeAirDrop];
    
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
        
        [controller presentViewController:activityVC animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = activityVC.popoverPresentationController;
        if (popover){
            popover.sourceView = controller.view;
            popover.sourceRect = CGRectMake(controller.view.center.x, controller.view.center.y, 0, 0);
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        
    }else{
        [controller presentViewController:activityVC animated:YES completion:nil];
    }
    
//    [controller presentViewController:activityVC animated:YES completion:nil];
}
@end
