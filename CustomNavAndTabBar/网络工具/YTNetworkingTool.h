//
//  YTNetworkingTool.h
//  CustomNavAndTabBar
//
//  Created by 付宝网络 on 2018/7/18.
//  Copyright © 2018年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
/**请求方式枚举*/
typedef NS_ENUM(NSUInteger,HttpRquestType){
    /**GET请求*/
    HTTP_REQUEST_GET = 0,
    /**POST请求*/
    HTTP_REQUEST_POST,
};

/**请求数据格式枚举*/
typedef NS_ENUM(NSUInteger,HttpRequestSerializer) {
    /**请求数据（默认）为json格式*/
    HttpRequestSerializerJSON,
    /**请求数据为二进制数据*/
    HttpRequestSerializerData,
};
/**响应数据类型枚举*/
typedef NS_ENUM(NSUInteger,HttpResponseType) {
    /**响应数据（默认）为json格式*/
    HttpResponseJSON = 0,
    /**响应数据为二进制数据*/
    HttpResponseData,
};
/**请求成功回调block*/
typedef void(^HttpRequetSuccess)(id responseObject);

/**请求失败回调block*/
typedef void(^HttpRequesError)(NSError *error);
/**返回响应头信息*/
typedef void(^HTTPURLResponse)(NSHTTPURLResponse *response);

@interface YTNetworkingTool : NSObject


/**
 *  GET请求
 *
 *  @param url           请求地址
 *  @param responseType  返回数据格式
 *  @param params        请求参数
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *  @param responese     请求响应头
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionDataTask *)GET:(NSString *)url responeseType:(HttpResponseType )responseType parameters:(NSDictionary *)params success:(HttpRequetSuccess)success failure:(HttpRequesError)failure responeseHeader:(HTTPURLResponse)responese;


/**
 *  POST请求
 *
 *  @param url           请求地址
 *  @param responseType  返回数据格式
 *  @param params        请求参数
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *  @param responese     请求响应头
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionDataTask *)POST:(NSString *)url responeseType:(HttpResponseType )responseType parameters:(NSDictionary *)params success:(HttpRequetSuccess)success failure:(HttpRequesError)failure responeseHeader:(HTTPURLResponse)responese;

/**
 *  取消全部的HTTP请求
 */
+ (void)cancelAllRequest;

/**
 *  取消指定URL的HTTP请求
 */
+ (void)cancelRequestWithURL:(NSString *)URL;


#pragma mark - 设置AFHTTPSessionManager相关属性
#pragma mark 注意: 因为全局只有一个AFHTTPSessionManager实例,所以以下设置方式全局生效
/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/**
 *  设置请求头内容
 *
 *  @param dic 内容字典
 */
+ (void)setHttpHeaderFieldWithDic:(NSDictionary *)dic;

/**
 *  清理cookie
 *
 */
+ (void)clearnCookie;
@end
