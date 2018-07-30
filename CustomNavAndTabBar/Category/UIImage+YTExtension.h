//
//  UIImage+YTCategory.h
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/7/4.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YTExtension)
/**
 *  将颜色转换为图片
 */
+ (UIImage *)createImageWithColor:(UIColor*) color;

/**
 *  修正上传服务器后,图片的显示方向
 *
 */
- (UIImage *)fixOrientation;

/**
 * 裁剪圆形图片
 */


@end
