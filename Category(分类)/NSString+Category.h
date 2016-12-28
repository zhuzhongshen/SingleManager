//
//  NSString+Category.h
//  LiLian
//
//  Created by nihao on 16/9/7.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Category)

/*
-(BOOL)isBlank;
-(BOOL)isValid;
 */

/**
 *返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
- (CGSize)sizeWithFont:(UIFont *)font  maxSize:(CGSize)maxSize;
//md5
- (NSString *)md5;

- (NSString *)removeWhiteSpacesFromString;


- (NSUInteger)countNumberOfWords;
- (BOOL)containsString:(NSString *)subString;
- (BOOL)isBeginsWith:(NSString *)string;
- (BOOL)isEndssWith:(NSString *)string;

- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)addString:(NSString *)string;
- (NSString *)removeSubString:(NSString *)subString;

- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (BOOL)isInThisarray:(NSArray*)array;

+ (NSString *)getStringFromArray:(NSArray *)array;
- (NSArray *)getArray;
//获取应用版本
+ (NSString *)getMyApplicationVersion;
//获取应用名称
+ (NSString *)getMyApplicationName;

- (NSData *)convertToData;
+ (NSString *)getStringFromData:(NSData *)data;
//是否是邮箱格式
- (BOOL)isValidEmail;
//是否是正确的电话号码
- (BOOL)isVAlidPhoneNumber;
- (BOOL)isValidUrl;

//返回时间格式 format 你想要的格式


+ (NSString *)lr_stringDateWithFormat:(NSString *)format;

+ (NSString *)lr_stringDate;
//返回加密字符串
//返回加密字符串
+ (NSString *)getSignString;
+ (NSString *)getRandomNumber;
+ (NSString *)getTamp;
//当前时间时间戳
+ (NSString *)getCureentTime;
//返回需要转化时间时间戳
+ (NSString *)getChangeTimeInterval:(NSString *)string;
//返回需要转化时间时间戳
+ (NSString *)getChangeChoseTimeInterval:(NSString *)string;
//时间戳转时间格式
+ (NSString *)getChangeIntervalToTimeString:(NSString *)timeInterval;
//获取当前时间-输出2015年11月25日 17:21格式数据
+ (NSString *)outputNowDate;
//返回加密后的信息
+ (NSDictionary *)signDict;
//返回uid
+ (NSString *)uid;

+ (NSString *)changeName:(NSDate  *)date;

//app版本
+ (NSString *)getAppVersion;
// app build版本
+ (NSString *)getAppBuild;
- (NSString *)URLEncodedString;

- (NSString *)decodeString:(NSString*)encodedString;
//一次初始化
+ (NSDateFormatter *)defaultFormatter;
//时间格式字符串转化为时间戳 formatter 设置你要的时间格式
+ (NSInteger)timerWithDateString:(NSString *)dateString andFormatter:(NSString *)formatter;



@end




