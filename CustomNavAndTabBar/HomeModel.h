//
//  HomeModel.h
//  CustomNavAndTabBar
//
//  Created by yatao li on 2019/4/10.
//  Copyright © 2019年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : JSONModel
@property (nonatomic,strong) NSString *title;
@property (nonatomic) NSInteger rows;
@property (nonatomic,strong) NSArray *info;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@interface HomeSmallModel : JSONModel
@property (nonatomic,strong) NSString *filename;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat likeNum;
@property (nonatomic) BOOL isCollection;
@end

NS_ASSUME_NONNULL_END


