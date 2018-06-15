//
//  NetworkingManager.m
//  LAFNetworking
//
//  Created by suge on 2017/7/1.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "NetworkingManager.h"
#import <CoreTelephony/CTCellularData.h>
@interface NetworkingManager ()
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic,assign) AFNetworkReachabilityStatus networkStatus;

@end


@implementation NetworkingManager

#pragma mark - 创建单例类
+ (instancetype)shareManager{
    
    static NetworkingManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"shareManager");
        manager = [[NetworkingManager alloc] init];
    });
    return manager;
}

+ (void)initialize{
    
    NSLog(@"initialize");
    
    NetworkingManager *manager = [NetworkingManager shareManager];
    manager.sessionManager = [AFHTTPSessionManager manager];
    manager.requestSerializer = HttpRequestSerializerJSON;
    manager.responseSerializer = HttpResponseSerializerJSON;
    /*! 设置请求超时时间，默认：30秒 */
    manager.timeoutInterval = 30;
    
    // 配置自建证书的Https请求
    [self ba_setupSecurityPolicy];
    [[NetworkingManager shareManager] startNetworkMonitoring];
}


#pragma mark - 配置自建证书的Https请求，只需要将CA证书文件放入根目录就行
+ (void)ba_setupSecurityPolicy
{
    //    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    
    if (cerSet.count == 0)
    {
        /*!
         采用默认的defaultPolicy就可以了. AFN默认的securityPolicy就是它, 不必另写代码. AFSecurityPolicy类中会调用苹果security.framework的机制去自行验证本次请求服务端放回的证书是否是经过正规签名.
         */
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        [NetworkingManager shareManager].sessionManager.securityPolicy = securityPolicy;
    }else{
        /*! 自定义的CA证书配置如下： */
        /*! 自定义security policy, 先前确保你的自定义CA证书已放入工程Bundle */
        /*!
         https://api.github.com网址的证书实际上是正规CADigiCert签发的, 这里把Charles的CA根证书导入系统并设为信任后, 把Charles设为该网址的SSL Proxy (相当于"中间人"), 这样通过代理访问服务器返回将是由Charles伪CA签发的证书.
         */
        // 使用证书验证模式
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        // 如果需要验证自建证书(无效证书)，需要设置为YES
        securityPolicy.allowInvalidCertificates = YES;
        // 是否需要验证域名，默认为YES
        //    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
        
        
        [NetworkingManager shareManager].sessionManager.securityPolicy = securityPolicy;
        
        
        /*! 如果服务端使用的是正规CA签发的证书, 那么以下几行就可去掉: */
        //            NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
        //            AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        //            policy.allowInvalidCertificates = YES;
        //            BANetManagerShare.sessionManager.securityPolicy = policy;
    }
}

#pragma mark - 自定义请求头
- (void)setHttpHeaderFieldDictionary:(NSDictionary *)httpHeaderFieldDictionary{
    _httpHeaderFieldDictionary = httpHeaderFieldDictionary;
    if (![httpHeaderFieldDictionary isKindOfClass:[NSDictionary class]])
    {
        //NSLog(@"请求头数据有误，请检查！");
        return;
    }
    NSArray *keyArray = httpHeaderFieldDictionary.allKeys;
    
    if (keyArray.count <= 0)
    {
        //NSLog(@"请求头数据有误，请检查！");
        return;
    }
    
    for (NSInteger i = 0; i < keyArray.count; i ++)
    {
        NSString *keyString = keyArray[i];
        NSString *valueString = httpHeaderFieldDictionary[keyString];
        
        [NetworkingManager ba_setValue:valueString forHTTPHeaderKey:keyString];
    }
    
}
+ (void)ba_setValue:(NSString *)value forHTTPHeaderKey:(NSString *)HTTPHeaderKey
{
    [[NetworkingManager shareManager].sessionManager.requestSerializer setValue:value forHTTPHeaderField:HTTPHeaderKey];
}


#pragma mark - 设置请求参数的格式（默认HttpRequestSerializerJSON）
- (void)setRequestSerializer:(HttpRequestSerializer)requestSerializer
{
    _requestSerializer = requestSerializer;
    switch (requestSerializer) {
        case HttpRequestSerializerJSON:
        {
            [NetworkingManager shareManager].sessionManager.requestSerializer = [AFJSONRequestSerializer serializer] ;
        }
            break;
        case HttpRequestSerializerData:
        {
            [NetworkingManager shareManager].sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer] ;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 设置请求响应的格式（默认HttpResponseSerializerJSON）
- (void)setResponseSerializer:(HttpResponseSerializer)responseSerializer
{
    _responseSerializer = responseSerializer;
    switch (responseSerializer) {
        case HttpResponseSerializerJSON:
        {
            [NetworkingManager shareManager].sessionManager.responseSerializer = [AFJSONResponseSerializer serializer] ;
        }
            break;
        case HttpResponseSerializerData:
        {
            [NetworkingManager shareManager].sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 请求超时时间（默认为30秒）
- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval{
    _timeoutInterval = timeoutInterval;
    [NetworkingManager shareManager].sessionManager.requestSerializer.timeoutInterval = _timeoutInterval;
}
#pragma mark - GET 请求方式
+ (NSURLSessionDataTask *)GET:(NSString *)urlString responeseType:(HttpResponseType )responseType parameters:(NSDictionary *)params successBlock:(HttpRequetSuccess)success failure:(HttpRequesError)errorBlock sessionDataTask:(URLSessionDataTask)dataTask{
    __weak typeof(self) weakSelf = self;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (responseType == 1){
        [NetworkingManager shareManager].sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    }else{
        [NetworkingManager shareManager].sessionManager.responseSerializer = [AFJSONResponseSerializer serializer] ;
    }
    NSURLSessionDataTask *task = [[NetworkingManager shareManager].sessionManager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf resetNetWorkingConfig];
        if (success){
            success(responseObject);
        }
        if (dataTask) {
            dataTask(task);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf resetNetWorkingConfig];
        if (errorBlock)
        {
            errorBlock(error);
        }
        if (dataTask) {
            dataTask(task);
        }
    }];
    return task;
}
#pragma mark - POST 请求方式
+ (NSURLSessionDataTask *)POST:(NSString *)urlString responeseType:(HttpResponseType )responseType parameters:(NSDictionary *)params successBlock:(HttpRequetSuccess)success failure:(HttpRequesError)errorBlock sessionDataTask:(URLSessionDataTask)dataTask{
    __weak typeof(self) weakSelf = self;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (responseType == 1){
        [NetworkingManager shareManager].sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    }else{
        [NetworkingManager shareManager].sessionManager.responseSerializer = [AFJSONResponseSerializer serializer] ;
    }
    NSURLSessionDataTask *task = [[NetworkingManager shareManager].sessionManager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf resetNetWorkingConfig];
        if (success){
            success(responseObject);
        }
        if (dataTask) {
            dataTask(task);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf resetNetWorkingConfig];
        if (errorBlock){
            errorBlock(error);
        }
        if (dataTask) {
            dataTask(task);
        }
        
    }];
    
    return task;
}
#pragma mark - 重新配置网络请求
+ (void)resetNetWorkingConfig{
    [NetworkingManager shareManager].sessionManager.requestSerializer.timeoutInterval = 30;
    [NetworkingManager shareManager].httpHeaderFieldDictionary = nil;
    
    
}
#pragma mark - 清理cookie
+ (void)clearnCookie{
    [NetworkingManager shareManager].sessionManager.requestSerializer.HTTPShouldHandleCookies = NO;
}
#pragma mark - 添加网络监听
- (void)startNetworkMonitoring{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [NetworkingManager shareManager].networkStatus = manager.networkReachabilityStatus;
    [manager startMonitoring];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkingStatusDidChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}
- (void)networkingStatusDidChanged:(NSNotification*)info{
    NSDictionary *inforDict = [info userInfo];
    NSString *statusStr = [self getStringFromDict:inforDict withKey:AFNetworkingReachabilityNotificationStatusItem];
    if (statusStr == nil || [self isBlankStringWithStr:statusStr]) {
        statusStr = [self getStringFromDict:inforDict withKey:@"LCNetworkingReachabilityNotificationStatusItem"];
    }
    
    NSInteger status   = [statusStr integerValue];
    if (status == [NetworkingManager shareManager].networkStatus) {
        return;
    }
    
    [NetworkingManager shareManager].networkStatus = status;
    
    if (status == AFNetworkReachabilityStatusNotReachable || status == AFNetworkReachabilityStatusUnknown) {
        //没有网络
        [self checkNetWorkAuthor];
    }else{
        //有网络
        
    }
}
#pragma mark - 判断字符串是否为空
- (BOOL)isBlankStringWithStr:(NSString *)string{
    if (string == NULL || [string isEqual:nil] || [string isEqual:Nil] || string == nil)
        return  YES;
    if ([string isEqual:[NSNull null]])
        return  YES;
    if (![string isKindOfClass:[NSString class]] )
        return  YES;
    if (0 == [string length] || 0 == [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
        return  YES;
    if([string isEqualToString:@"(null)"])
        return  YES;
    if([string isEqualToString:@"<null>"])
        return  YES;
    return NO;
}

- (NSString *)getStringFromDict:(NSDictionary*)dict withKey:(id)key{
    
    NSString *string = @"";
    if (dict && [dict objectForKey:key]) {
        string = [NSString stringWithFormat:@"%@",[dict objectForKey:key]];
    }
    
    if (string == nil || [self isBlankStringWithString:string]) {
        string = @"";
    }
    
    return string;
}
- (BOOL)isBlankStringWithString:(NSString *)str{
    if (str == NULL || [str isEqual:nil] || [str isEqual:Nil] || str == nil)
        return  YES;
    if ([str isEqual:[NSNull null]])
        return  YES;
    if (![str isKindOfClass:[NSString class]] )
        return  YES;
    if (0 == [str length] || 0 == [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
        return  YES;
    if([str isEqualToString:@"(null)"])
        return  YES;
    if([str isEqualToString:@"<null>"])
        return  YES;
    return NO;
}

#pragma mark - 检查网络是否授权

- (void)checkNetWorkAuthor{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        CTCellularData *cellularData = [[CTCellularData alloc] init];
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *str1 = @"WiFi或蜂窝网络已经断开";
                NSString *str2 = @"\n请检查您的网络设置";
                NSString *str3 = @"";
                NSString *str4 = @"";
                if (cellularData.restrictedState == kCTCellularDataRestricted) {
                    str1 = @"系统已为此应用关闭无线局域网";
                    str2 = @"\n您可以在“";
                    str3 = @"设置";
                    str4 = @"”中为此应用打开无线局域网";
                }
                
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setAlignment:NSTextAlignmentCenter];
                [style setLineSpacing:4];
                NSDictionary *dict1 = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                        NSFontAttributeName:[UIFont systemFontOfSize:17],
                                        NSParagraphStyleAttributeName:style};
                NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:str1 attributes:dict1];
                
                NSDictionary *dict2 = @{NSForegroundColorAttributeName:[UIColor blueColor],
                                        NSFontAttributeName:[UIFont systemFontOfSize:14],
                                        NSParagraphStyleAttributeName:style};
                NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:str2 attributes:dict2];
                NSAttributedString *string4 = [[NSAttributedString alloc] initWithString:str4 attributes:dict2];
                
                NSDictionary *dict3 = @{NSForegroundColorAttributeName:[UIColor blueColor],
                                        NSFontAttributeName:[UIFont systemFontOfSize:14],
                                        NSParagraphStyleAttributeName:style};
                NSAttributedString *string3 = [[NSAttributedString alloc] initWithString:str3 attributes:dict3];
                
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
                [string appendAttributedString:string1];
                [string appendAttributedString:string2];
                [string appendAttributedString:string3];
                [string appendAttributedString:string4];
                
                NSString *messageStr  = [NSString stringWithFormat:@"%@%@%@%@",str1,str2,str3,str4];
                
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:messageStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                [alerView show];
                
            });
        };
    }else{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"请检查您的网络" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alerView show];
    }
    
}



@end
