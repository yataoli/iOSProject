//
//  UITextField+Category.h
//  SugeiOS
//
//  Created by suge on 2017/6/5.
//  Copyright © 2017年 素格. All rights reserved.
//
/* 自动换行方法
     - (void)textViewDidChange:(UITextView *)textView{
 
     CGRect frame = textView.frame;
     CGFloat textViewHeight = textView.contentSize.height;
     if (textViewHeight >= 80) {
     textViewHeight = 80;
     }else{
     if (textViewHeight <= 50){
     textViewHeight = 50;
     }
     }
     frame.size.height = textViewHeight;
 
     textView.frame = frame;
 
     }
*/

#import <UIKit/UIKit.h>

@interface UITextField (YTExtension)
/**
 *创建一个带左边站位view的textFeild
 */
+ (UITextField *)createTextFieldWithLeftViewWidth:(CGFloat )width;
/**
 *创建一个带左边图片的textFeild
 */
+ (UITextField *)createTextFieldWithLeftImageViewSize:(CGFloat)size andImageName:(NSString *)name andTFHeight:(CGFloat)height;
@end
