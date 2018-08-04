//
//  NSString+Category.m
//  SugeiOS
//
//  Created by suge on 2016/12/5.
//  Copyright © 2016年 素格. All rights reserved.
//

#import "NSString+YTExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
@implementation NSString (YTExtension)
#pragma mark - 计算字符串空间
- (CGRect)rectWithStringBoundingSize:(CGSize )stringSize withStringFont:(UIFont *)font{
    CGRect rect = [self boundingRectWithSize:stringSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect;
}

#pragma mark - MD5加密
-(NSString *)md5
{
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}



#pragma mark - 把字典转换成JSON格式字符串
+ (NSString *)DicToJsonStringWithDic:(NSDictionary *)dic{
    NSData *dicData =[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *dicDataJsonString =[[NSString alloc]initWithData:dicData encoding:NSUTF8StringEncoding];
    return dicDataJsonString;
}

#pragma mark - 把json字符串转化为json格式数据
- (id)stringToJSON{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
     return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
}
#pragma mark - 正则匹配手机号码
- (BOOL)checkTelNumber
{
    NSString *pattern = @"^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma mark - 检查 密码是否是 6-20 数字密码
- (BOOL)checkPassWord
{
    NSString *pattern = @"^[0-9A-Za-z]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma mark - 正则匹配用户身份证号 15 或 18 位
- (BOOL)checkUserIdCard{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
#pragma mark - 正则匹配URL
- (BOOL)isUrlString{

    NSString *pattern = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
#pragma mark - 正则匹配用户名是否可用(数字字母下划线横杠汉字)
- (BOOL)checkAccount{
    NSString *pattern = @"^[a-zA-Z0-9_\\-\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
#pragma mark - 正则匹配纯数字
- (BOOL)checkAllNumber{
    NSString *pattern = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
#pragma mark - 判断字符串是否为空
- (BOOL)isBlankString{
    if (self == NULL || [self isEqual:nil] || [self isEqual:Nil] || self == nil)
        return  YES;
    if ([self isEqual:[NSNull null]])
        return  YES;
    if (![self isKindOfClass:[NSString class]] )
        return  YES;
    if (0 == [self length] || 0 == [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
        return  YES;
    if([self isEqualToString:@"(null)"])
        return  YES;
    if([self isEqualToString:@"<null>"])
        return  YES;
    return NO;
}

#pragma mark - 字符串是否包含中文
- (BOOL)isContainsChinese{
    for (NSInteger i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (0x4E00 <= ch && ch <= 0x9FA5) {
            return YES;
        }
    }
    return NO;

}
#pragma mark - 将字符串转化为拼音
- (NSString *)pinyin
{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}
#pragma mark - 返回字符串拼音首字母
- (NSString *)pinyinInitial
{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSArray *word = [str componentsSeparatedByString:@" "];
    NSMutableString *initial = [[NSMutableString alloc] initWithCapacity:str.length / 3];
    for (NSString *str in word) {
        [initial appendString:[str substringToIndex:1]];
    }
    return initial;
}
#pragma mark - 判断手机号码运营商
- (NSString *)telNumberType{
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    if ([[NSPredicate predicateWithFormat: @"SELF MATCHES %@", CM] evaluateWithObject:self]) {
        return @"中国联通";
    }
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    if ([[NSPredicate predicateWithFormat: @"SELF MATCHES %@", CU] evaluateWithObject:self]) {
        return @"中国联通";
    }
    
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    if ([[NSPredicate predicateWithFormat: @"SELF MATCHES %@", CT] evaluateWithObject:self]) {
        return @"中国电信";
    }
    
    return @"";
    
}
@end
