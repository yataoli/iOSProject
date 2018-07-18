//
//  YTNetworkingTool.m
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/7/18.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "YTNetworkingTool.h"



@implementation YTNetworkingTool
static AFHTTPSessionManager *_manager;
static NSMutableArray *_allSessionTaskArray;
+ (void)initialize{
    _manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer.timeoutInterval = 30.0f;
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    // 配置自建证书的Https请求
    [self ba_setupSecurityPolicy];
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
       _manager.securityPolicy = securityPolicy;
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
        
        
        _manager.securityPolicy = securityPolicy;
        
        
        /*! 如果服务端使用的是正规CA签发的证书, 那么以下几行就可去掉: */
        //            NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
        //            AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        //            policy.allowInvalidCertificates = YES;
        //            BANetManagerShare.sessionManager.securityPolicy = policy;
    }
}
#pragma mark - GET请求
+ (NSURLSessionDataTask *)GET:(NSString *)url responeseType:(HttpResponseType )responseType parameters:(NSDictionary *)params success:(HttpRequetSuccess)success failure:(HttpRequesError)failure responeseHeader:(HTTPURLResponse)responese{
    typeof(self) __weak weakSelf = self;
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (responseType == 1){
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else{
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    NSURLSessionDataTask *task = [_manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allSessionTaskArray] removeObject:task];
        success ? success(responseObject) : nil;
        
        responese ? responese((NSHTTPURLResponse *)task.response) : nil;
        [weakSelf resetNetWorkingConfig];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allSessionTaskArray] removeObject:task];
        failure ? failure(error) : nil;
        
        responese ? responese((NSHTTPURLResponse *)task.response) : nil;
        [weakSelf resetNetWorkingConfig];
    }];
    if (task) {
        [[self allSessionTaskArray] addObject:task];
    }
    return task;
}
#pragma mark - POST请求
+ (NSURLSessionDataTask *)POST:(NSString *)url responeseType:(HttpResponseType )responseType parameters:(NSDictionary *)params success:(HttpRequetSuccess)success failure:(HttpRequesError)failure responeseHeader:(HTTPURLResponse)responese{
    typeof(self) __weak weakSelf = self;
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    if (responseType == 1){
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else{
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    NSURLSessionDataTask *task = [_manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allSessionTaskArray] removeObject:task];
        success ? success(responseObject) : nil;
        
        responese ? responese((NSHTTPURLResponse *)task.response) : nil;
        [weakSelf resetNetWorkingConfig];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allSessionTaskArray] removeObject:task];
        failure ? failure(error) : nil;
        
        responese ? responese((NSHTTPURLResponse *)task.response) : nil;
        [weakSelf resetNetWorkingConfig];
    }];
    if (task) {
        [[self allSessionTaskArray] addObject:task];
    }
    return task;
}

+ (void)cancelAllRequest{
    // 锁操作
    @synchronized(self) {
        [[self allSessionTaskArray] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTaskArray] removeAllObjects];
    }
}

#pragma mark - 取消指定URL的HTTP请求
+ (void)cancelRequestWithURL:(NSString *)URL{
    if (!URL) {return;}
    @synchronized (self) {
        [[self allSessionTaskArray] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTaskArray] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - 存储着所有的请求task数组
+ (NSMutableArray *)allSessionTaskArray {
    if (!_allSessionTaskArray) {
        _allSessionTaskArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _allSessionTaskArray;
}



#pragma mark - *******重置AFHTTPSessionManager相关属性********
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _manager.requestSerializer.timeoutInterval = time;
}

#pragma mark - 自定义请求头
+ (void)setHttpHeaderFieldWithDic:(NSDictionary *)dic{
    if (![dic isKindOfClass:[NSDictionary class]])
    {
        //NSLog(@"请求头数据有误，请检查！");
        return;
    }
    NSArray *keyArray = dic.allKeys;
    
    if (keyArray.count <= 0)
    {
        //NSLog(@"请求头数据有误，请检查！");
        return;
    }
    
    for (NSInteger i = 0; i < keyArray.count; i ++)
    {
        NSString *keyString = keyArray[i];
        NSString *valueString = dic[keyString];
        [_manager.requestSerializer setValue:valueString forHTTPHeaderField:keyString];
    }
    
}
#pragma mark - 清理cookie
+ (void)clearnCookie{
   _manager.requestSerializer.HTTPShouldHandleCookies = NO;
}

#pragma mark - 重新配置网络请求
+ (void)resetNetWorkingConfig{
    _manager.requestSerializer.timeoutInterval = 30;
    
}

@end
