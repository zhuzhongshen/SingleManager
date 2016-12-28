//
//  NSString+Category.m
//  LiLian
//
//  Created by nihao on 16/9/7.
//  Copyright © 2016年 smart_small. All rights reserved.
//
#import "NSString+Category.h"
#import "SFHFKeychainUtils.h"
#import "Constants.h"
#import "RSATool.h"
#import "RSAObject.h"
#import "HBRSAHandler.h"
#import "LiLianTool.h"
#import "NSString+RSAKey.h"
#import "JSONKit.h"
#define  RSAPUBLICKEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMB/6ic1BoqJb+ckv4lX6iMw4Vhc3w5FYFgZC2bT47SAJUQKXqFI9rHLOAyOY//YVkiP31xTZYUlYGDZhEgBRTx7m+elSs/xvtJBjG8iPx2usLcdr9U7ryy1Si7uOKy0lpnOR/QvuLuKRCJl8eLRH4ZZq8+ycgi1Wv67airaVwnQIDAQAB"
#define  RSAPRIVATEKEY @"MIICXQIBAAKBgQDMB/6ic1BoqJb+ckv4lX6iMw4Vhc3w5FYFgZC2bT47SAJUQKXqFI9rHLOAyOY//YVkiP31xTZYUlYGDZhEgBRTx7m+elSs/xvtJBjG8iPx2usLcdr9U7ryy1Si7uOKy0lpnOR/QvuLuKRCJl8eLRH4ZZq8+ycgi1Wv67airaVwnQIDAQABAoGASxWuGa6CKuHQH3eEicjKP3q2dik1rq75ETGrRddSDZLkeIkKBejnFq4LSRul0GrGCkd33lhjNYGncrbSEHNqBvqPseCWREdARQxPbIQsnrQmhJBOTe8Ivq5NBDA3lDZGJCkBvIJIDBpOIMHXBhB8LAmWBExz04CcB/WVxhPCEIECQQDwLi/vpiG65n1Ob9U4+Z3vYWhEv7raSY6UNgykBg8e5zGrepTe5B0VGbqIzcB2OmSmn0Ftqg8lrxhLNTbuqTvNAkEA2XhGuJ6n0xLk5/m7nW2isUssmo3EIGw28a7KSlDQwrZ4visKYgFUKZ7rZFY+k5l6FTFMnEindb9L+JZbMUJYEQJBAKwLWbkf1u+LpVznTOQ4IkLUEp2UfaNZp3FRWjKwSGqJj5HXCAa1foOb33uZbvEBmRGl6HdGpv0GdK+C2euRfE0CQDlju04XWHSkZNIvHmriNvAQxZmX1e00gZ9wICRShXUNEHonA5tvfFVrgfU9qU/sTcJv+ya3KbIyJItaqoAqYPECQQDj0ahE/8SlrbLsReZVNnLpeDGHci19d87ig7fMKUA1pqOtoLq26A7oHm/9Ww1VcaZiB9gkYT37Yup8DavfgAdL"
/*
 #define  RSAPUBLICKEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDWNXvZXW8vw0SLCJsibzxx3bpWcphC/ln0tytoxqz6zG8JlGiDabRN8UXrxWRBMJH7tAM5cPQu658yOs0jjNUdVF7QtyfXJYaHhfedZbBi+kNKnekD0LtHjD84vuRB5Owm/bQY7Wkh3rRLKEI+LR1qy0TsS/1VgFSftpHGpLIShwIDAQAB"
 #define  RSAPRIVATEKEY @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANY1e9ldby/DRIsImyJvPHHdulZymEL+WfS3K2jGrPrMbwmUaINptE3xRevFZEEwkfu0Azlw9C7rnzI6zSOM1R1UXtC3J9clhoeF951lsGL6Q0qd6QPQu0eMPzi+5EHk7Cb9tBjtaSHetEsoQj4tHWrLROxL/VWAVJ+2kcakshKHAgMBAAECgYEAu3+jQbdUPJWKaLyGtlRxryWrFkJGXtWuvdKbL6JABWNuig8akHS0+0iGsIJeZ+Vw0sZV0DC7vFpIRbpMl6KNYvyBwbepqIDvHjRUBu+ytddGpWtw6BNM3/gjPGGYkgU8qtgLqovDmwtK5t+x0xYERjbQViGrE0U2lbhgFBKFyfkCQQD+NOiPdAe0NL7mDPRorJjvoGuYd5aI8Yi22U+7OrPjyMGJMwqZlTzR+yXRjn6kaZ5hjL6fU28oW4dWd06jivEjAkEA17hXHfaUa+PeMxkrLtZhHH02VAP5PLdpYxvRpy/+aRsmIsS1Bf5ybChCu0PO2bvKQdIllo8qECbZ4EtAojp5TQJAYMfV7p+3OyWFtGIkPyHPDBQgQqjs9/A1I6Aymc6spEFPZaO4GmbWA//BEzpT/tZzRSJnhJMoU84dBY9gsiT4zwJBALV1QxLZUJBQ5aBmE4UaoCWuzfxuO0Fvpx7PT9Qq8v7G75Vfkkawet+wHjIYH+/Xn5Muip/TXbaod63Mn1nXhiECQBHVo/TlUxnYERTlrlwYIZZeh0EXKRo+iTe1FX0Q210pC/IAnZZRfDfKcNpjsk9C+1Pi1IpmJ6kQQZVzEs4ZKGA="
 */
#define IOS8  [[[UIDevice currentDevice]systemVersion] doubleValue] >8.0
static NSDateFormatter *dateFormatter;
@implementation NSString (Category)
+ (NSDateFormatter *)defaultFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
    });
    return dateFormatter;
}
// Checking if String is Empty
- (BOOL)isBlank
{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
//Checking if String is empty or nil
- (BOOL)isValid
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]) ? YES :NO;
}
//返回字符串所占用的尺寸.
- (CGSize)sizeWithFont:(UIFont *)font   maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize contentSize;
    if (IOS8) {
        contentSize  = [self boundingRectWithSize:maxSize
                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                       attributes:attrs
                                          context:nil].size;}
    else{
        contentSize = [self sizeWithFont:font constrainedToSize:maxSize];
    }
    return contentSize;
}
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (int)(strlen(cStr)), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

// remove white spaces from String
- (NSString *)removeWhiteSpacesFromString
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

// Counts number of Words in String
- (NSUInteger)countNumberOfWords
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
    return count;
}
// If string contains substring
- (BOOL)containsString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}
// If my string starts with given string
- (BOOL)isBeginsWith:(NSString *)string
{
    return ([self hasPrefix:string]) ? YES : NO;
}
// If my string ends with given string
- (BOOL)isEndssWith:(NSString *)string
{
    return ([self hasSuffix:string]) ? YES : NO;
}
// Replace particular characters in my string with new character
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar
{
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}
// Get Substring from particular location to given lenght
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end
{
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

// Add substring to main String
- (NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

// Remove particular sub string from main string
-(NSString *)removeSubString:(NSString *)subString
{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}


// If my string contains ony letters
- (BOOL)containsOnlyLetters
{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// If my string contains only numbers
- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// If my string contains letters and numbers
- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

// If my string is available in particular array
- (BOOL)isInThisarray:(NSArray*)array
{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

// Get String from array
+ (NSString *)getStringFromArray:(NSArray *)array
{
    return [array componentsJoinedByString:@" "];
}

// Convert Array from my String
- (NSArray *)getArray
{
    return [self componentsSeparatedByString:@" "];
}

// Get My Application Version number
+ (NSString *)getMyApplicationVersion
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleVersion = [info objectForKey:@"CFBundleVersion"];
    NSString *shortVersion = [info objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@.%@", shortVersion, bundleVersion];
}

// Get My Application name
+ (NSString *)getMyApplicationName
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [info objectForKey:@"CFBundleDisplayName"];
    return name;
}


// Convert string to NSData
- (NSData *)convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// Get String from NSData
+ (NSString *)getStringFromData:(NSData *)data
{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
    
}

// Is Valid Email

- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

// Is Valid Phone

- (BOOL)isVAlidPhoneNumber
{
    /*
     支持手机号段:
     移动：139   138   137   136   135   134   147   150   151   152   157   158    159   178  182   183   184   187   188
     联通： 130   131   132   155   156   185   186   145   176
     电信： 133   153   177   180   181   189
     */
    NSString *regex = @"^0?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
}

// Is Valid URL

- (BOOL)isValidUrl
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

//返回时间格式字符串
+ (NSString *)lr_stringDateWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [NSString defaultFormatter];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
    
}


+ (NSString *)lr_stringDate {
    NSDateFormatter *dateFormatter = [NSString defaultFormatter];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

//返回加密字符串
+ (NSString *)getSignString
{
    
    return nil;
}

+ (NSString *)getRandomNumber{
    int num = (arc4random() % 10000);
    NSString *  randomNumber = [NSString stringWithFormat:@"%.4d", num];
    return randomNumber;
}

+ (NSString *)getTamp{
    NSDate *senddate = [NSDate date];
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    return date2;
}
//当前时间时间戳
+ (NSString *)getCureentTime{
    NSDate *senddate = [NSDate date];
    
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    return date2;
}
//返回需要转化时间时间戳
+ (NSString *)getChangeTimeInterval:(NSString *)string{
    
    NSString * changeStr = @"";
    NSString * cureentTime  = [self outputNowDate];
    NSArray * array = [cureentTime componentsSeparatedByString:@" "];
    if (array.count>=2) {
        
        NSString * times = [NSString stringWithFormat:@"%@ %@:00",array[0],string];
        
        NSDateFormatter *dateFormatter = [self defaultFormatter];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:times];
        changeStr   = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    }
    
    return changeStr;
}

//返回需要转化时间时间戳
+ (NSString *)getChangeChoseTimeInterval:(NSString *)string{
    
    
    
    NSString * times = [NSString stringWithFormat:@"%@ 00:00:00",string];
    
    NSDateFormatter *dateFormatter = [self defaultFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:times];
     NSString * changeStr   = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    
    return changeStr;
}

//时间戳转时间格式
+ (NSString *)getChangeIntervalToTimeString:(NSString *)timeInterval{
    
    NSTimeInterval time=[timeInterval doubleValue];//因为时差问题要加8小时 == 28800 sec
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter*dateFormatter = [NSString defaultFormatter];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}
//获取当前时间-输出2015年11月25日 17:21格式数据
+ (NSString *)outputNowDate{
    // @"yyyy-MM-dd HH:mm:ss"
    NSDateFormatter *formatter = [self defaultFormatter];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSDictionary *)signDict{
    
    
    NSDate *senddate = [NSDate date];
    
    
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    
    // 生成 "0000-9999" 4位验证码
    int num = (arc4random() % 10000);
    NSString *  randomNumber = [NSString stringWithFormat:@"%.4d", num];
    
    //判断是否登陆
    NSString * token = [SFHFKeychainUtils getPasswordForUsername:saveLoginTokenUserName andServiceName:saveLoginTokenServiceName  error:nil];
    
    
    LRLog(@"加密的token=====%@",token);
    
    if ([LiLianTool isBlankString:token]) {
    }else{
        
    }
    
    
    NSString * needEncryptStr = [NSString stringWithFormat:@"tamp=%@&token=%@&rand=%@",date2,token,randomNumber];
    
    
    
    HBRSAHandler * handler = [HBRSAHandler new];
    //rsa加密
    NSString *publicKeyFilePath = [[NSBundle mainBundle] pathForResource:@"rsa_text_public_key.pem" ofType:nil];
    [handler importKeyWithType:KeyTypePublic andPath:publicKeyFilePath];
    
    NSString * enString = [handler encryptWithPublicKey:needEncryptStr];
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"sign"] = enString;
    dic[@"tamp"] = date2;
    
    //dic[@"rand"] = randomNumber;
    return  dic;
}
//返回uid
+ (NSString *)uid{
    NSString * returnUid = @"";
    
    NSString * token  = [SFHFKeychainUtils getPasswordForUsername:saveLoginTokenUserName andServiceName:saveLoginTokenServiceName error:nil];
    if (![LiLianTool isBlankString:token]) {
        
        NSString * save = [SFHFKeychainUtils getPasswordForUsername:saveUserInfoUserName andServiceName:saveUserInfoServiceName error:nil];
        
        if (![LiLianTool isBlankString:save]) {
            NSDictionary * dic = [save objectFromJSONString];
            returnUid = dic[@"uid"];
        }
    }
    
    return returnUid;
}

//时间格式字符串 formatter 你想要的时间戳  转化为时间戳
+ (NSInteger)timerWithDateString:(NSString *)dateString andFormatter:(NSString *)formatter{
    
    NSInteger timer = 0;
    
    NSDateFormatter *dateFormatter = [NSString defaultFormatter];
    [dateFormatter setDateFormat:formatter];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Chongqing"];
    [dateFormatter setTimeZone:timeZone];
    NSDate *date = [dateFormatter dateFromString:dateString];
    //时间戳转化
    timer = [date timeIntervalSince1970];
    
    return timer;
}


+ (NSString *)changeName:(NSDate  *)date{
    
    NSDateFormatter * dataFormatter = [NSString defaultFormatter];
    [dataFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    //  dataFormatter.dateFormat = @"YYYY-MM-DD";
    [dataFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSMutableString * choseDate = [NSMutableString stringWithFormat:@"%@",[dataFormatter stringFromDate:date]];
    
    NSString * year = @"年";
    NSString * month = @"月";
    NSString * day = @"日";
    
    NSRange yearRange = [choseDate rangeOfString:year];
    
    NSRange monthRange = [choseDate rangeOfString:month];
    NSRange dayRange = [choseDate rangeOfString:day];
    
    
    [choseDate replaceCharactersInRange:yearRange withString:@"-"];
    [choseDate replaceCharactersInRange:monthRange withString:@"-"];
    [choseDate replaceCharactersInRange:dayRange withString:@""];
    
    
    NSArray * array = [choseDate componentsSeparatedByString:@"-"];
    
    
    NSString * yearString = [NSString stringWithFormat:@"%@",array[0]];
    NSString * monthString  =   [NSString stringWithFormat:@"%@",array[1]];
    NSString * dayString  =   [NSString stringWithFormat:@"%@",array[2]];
    if ( monthString.length < 2) {
        monthString = [NSString stringWithFormat:@"0%@",array[1]];
    }
    
    
    if (dayString.length <2) {
        dayString  =  [NSString stringWithFormat:@"0%@",array[2]];
    }
    
    
    return [NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];
    
    
}

+ (NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return  app_Version;
}

+ (NSString *)getAppBuild{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    //app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return  app_build;
}

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

//URLDEcode
- (NSString *)decodeString:(NSString*)encodedString

{
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}



- (void)getWeekBeginAndEnd
{
    //获取当前周的开始和结束日期
    int currentWeek = 0;
    NSDate * newDate = [NSDate date];
    NSTimeInterval secondsPerDay1 = 24 * 60 * 60 * (abs(currentWeek)*7);
    if (currentWeek > 0)
    {
        newDate = [newDate dateByAddingTimeInterval:+secondsPerDay1];//目标时间
    }else{
        newDate = [newDate dateByAddingTimeInterval:-secondsPerDay1];//目标时间
    }
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval - 1];
    }else {
        return;
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    NSLog(@"beginString:%@",beginString);
    NSLog(@"endString:%@",endString);
    
}


/** *  获取当前时间所在一周的第一天和最后一天 */
- (void)getCurrentWeek{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday   fromDate:now];
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    NSLog(@"weekDay:%ld  day:%ld",weekDay,day);
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 7 - weekDay;
    }
    NSArray *currentWeeks = [self getCurrentWeeksWithFirstDiff:firstDiff lastDiff:lastDiff];   NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    NSDateFormatter *formater = [NSString defaultFormatter];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"一周开始 %@",[formater stringFromDate:firstDayOfWeek]);
    NSLog(@"当前 %@",[formater stringFromDate:now]);
    NSLog(@"一周结束 %@",[formater stringFromDate:lastDayOfWeek]);
    NSLog(@"currentWeeks===%@",currentWeeks);
    
}

//获取一周时间 数组
- (NSMutableArray *)getCurrentWeeksWithFirstDiff:(NSInteger)first lastDiff:(NSInteger)last{    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    for (NSInteger i = first; i < last + 1; i ++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [NSString defaultFormatter];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];
        //几月几号//NSString *dateStr = @"5月31日";
        NSDateFormatter *weekFormatter = [NSString defaultFormatter];
        [weekFormatter setDateFormat:@"EEEE"];
        //星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *weekStr = [weekFormatter stringFromDate:curDate];
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@(%@)",dateStr,weekStr];
        
        [eightArr addObject:strTime];
    }
    return eightArr;
}


//最近一周的时间
//NSTimeInterval secondsPerDay = 24 * 60 * 60;
//NSDate * today = [NSDate date];
//NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
//[myDateFormatter setDateFormat:@"yyyy/MM/dd"];
//for (int i = 0; i < 7; i ++) {
//    NSString *dateString = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:i * secondsPerDay]];
//    NSLog(@"dateString%@:",dateString);
//}
@end


