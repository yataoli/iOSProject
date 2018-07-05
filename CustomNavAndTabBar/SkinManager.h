//
//  SkinManager.h
//  CustomNavAndTabBar
//
//  Created by suge on 2017/8/7.
//  Copyright © 2017年 李亚涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SkinManager : NSObject
+ (instancetype)shareSkinManager;
@property (nonatomic,strong) NSString *currentSkin;

@property (nonatomic,strong) UIImage *myImage;
@end
