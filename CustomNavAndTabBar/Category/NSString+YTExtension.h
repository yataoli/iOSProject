//
//  NSString+Category.h
//  SugeiOS
//
//  Created by suge on 2016/12/5.
//  Copyright © 2016年 素格. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (YTExtension)
/**
 * 计算字符串空间大小
 */
- (CGRect)rectWithStringBoundingSize:(CGSize )stringSize withStringFont:(UIFont *)font;

/**
 *MD5加密
 */
-(NSString *)md5;

/**
 *把字典转换成JSON格式字符串
 */
+ (NSString *)DicToJsonStringWithDic:(NSDictionary *)dic;

/**
 * 把json字符串转化为json格式数据
 */
- (id)stringToJSON;

/**
 *正则匹配手机号码
 */
- (BOOL)checkTelNumber;

/**
 * 判断手机号码运营商
 */
- (NSString *)telNumberType;

/**
 *  检查 密码是否是 6-20 数字密码
 */
- (BOOL)checkPassWord;

/**
 *正则匹配用户身份证号 15 或 18 位
 */
- (BOOL)checkUserIdCard;

/**
 *正则匹配URL    
 */
- (BOOL)isUrlString;
/**
 * 正则匹配用户名是否可用(数字字母下划线横杠汉字)
 */
- (BOOL)checkAccount;

/**
 * 正则匹配纯数字
 */
- (BOOL)checkAllNumber;

/**
 * 字符串非空判断
 */
- (BOOL)isBlankString;

/**
 * 判断字符串中是否包含中文
 */
- (BOOL)isContainsChinese;

/**
 * 将字符串转化为拼音
 */
- (NSString *)pinyin;

/**
 * 返回字符串拼音首字母
 */
- (NSString *)pinyinInitial;

@end
