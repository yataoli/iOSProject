//
//  LoginViewModel.m
//  CustomNavAndTabBar
//
//  Created by suge on 2017/9/4.
//  Copyright © 2017年 李亚涛. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel
- (void)loginSuccess:(void (^)(id))success fail:(void (^)(NSError *))fail{
    NSDictionary *jiaMiDic = @{@"phone":_phoneString,@"password":_passwordString} ;
    
    NSString *accountJsonString = [NSString DicToJsonStringWithDic:jiaMiDic];
    
    NSString *jiaMiData = aesEncryptString(accountJsonString, passwordKey);
    
    NSDictionary *dic = @{@"account":jiaMiData } ;
    [YTNetworkingTool POST:@"http://139.129.245.200:80/bulu/customer/login" responeseType:0 parameters:dic success:^(id responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            MeMessageModel *model = [[MeMessageModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
            [self.dataSource addObject:model];
        }
    } failure:^(NSError *error) {
        fail(error);
    } responeseHeader:^(NSHTTPURLResponse *response) {
        
    }];
    
    
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataSource;
}
@end
