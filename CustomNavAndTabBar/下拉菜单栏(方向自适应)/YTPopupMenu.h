//
//  YTPopupMenu.h
//  UniversalProject
//
//  Created by yatao li on 2018/7/7.
//  Copyright © 2018年 李亚涛. All rights reserved.
//

#ifndef YTPopupMenu_h
#define YTPopupMenu_h

#import "YBPopupMenu.h"

#endif /* YTPopupMenu_h */

/*
 ------------------使用方法-------------------------
    导入 YTPopupMenu.h 头文件
 
     依赖指定view弹出(推荐方法) ICONS是图片数组
 
    1.[YBPopupMenu showRelyOnView:sender titles:@[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888"] icons:ICONS menuWidth:120 delegate:self];
 
 
     2.[YBPopupMenu showRelyOnView:sender titles:@[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888"] icons:nil menuWidth:100 otherSettings:^(YBPopupMenu *popupMenu) {
     popupMenu.priorityDirection = YBPopupMenuPriorityDirectionLeft;
     popupMenu.borderWidth = 1;
     popupMenu.borderColor = [UIColor redColor];
     }];
 
    在指定位置弹出
 
    1.[YBPopupMenu showAtPoint:point titles:@[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888"] icons:nil menuWidth:110 delegate:self];
 
 
 
     2.[YBPopupMenu showAtPoint:point titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
     popupMenu.dismissOnSelected = NO;
     popupMenu.isShowShadow = YES;
     popupMenu.delegate = self;
     popupMenu.offset = 10;
     popupMenu.type = YBPopupMenuTypeDark;
     popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
     }];
 
 
    输入框上方提示内容
     #pragma mark - UITextFieldDelegate
     - (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
     {
     _popupMenu = [YBPopupMenu showRelyOnView:textField titles:@[@"密码必须为数字、大写字母、小写字母和特殊字符中至少三种的组合，长度不少于8且不大于20"] icons:nil menuWidth:textField.bounds.size.width otherSettings:^(YBPopupMenu *popupMenu) {
     popupMenu.delegate = self;
     popupMenu.showMaskView = NO;
     popupMenu.priorityDirection = YBPopupMenuPriorityDirectionBottom;
     popupMenu.maxVisibleCount = 1;
     popupMenu.itemHeight = 60;
     popupMenu.borderWidth = 1;
     popupMenu.fontSize = 12;
     popupMenu.dismissOnTouchOutside = YES;
     popupMenu.dismissOnSelected = NO;
     popupMenu.borderColor = [UIColor brownColor];
     popupMenu.textColor = [UIColor brownColor];
     }];
     return YES;
     }
 
     - (BOOL)textFieldShouldReturn:(UITextField *)textField
     {
     [_popupMenu dismiss];
     return YES;
     }
 
 
     #pragma mark - YBPopupMenuDelegate 点击事件回调
     - (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
     {
     //推荐回调
     NSLog(@"点击了 %@ 选项",ybPopupMenu.titles[index]);
     }
 
    #pragma mark - YBPopupMenuDelegate 开始消失
     - (void)ybPopupMenuBeganDismiss
     {
     if (self.textField.isFirstResponder) {
     [self.textField resignFirstResponder];
     }
     }


 
 
 
 ------------------使用方法-------------------------
*/
