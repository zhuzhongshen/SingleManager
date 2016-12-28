//
//  UIColor+Hex.h
//  LiLian
//
//  Created by nihao on 16/9/7.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DEFAULT_VOID_COLOR [UIColor whiteColor]

typedef enum : NSUInteger {
    UIGradientStyleLeftToRight,
    UIGradientStyleRadial,
    UIGradientStyleTopToBottom,
} UIGradientStyle;

@interface UIColor (Hex)

//获得颜色代码
+(UIColor *)colorWithRGB:(int)color alpha:(float)alpha;
//颜色转化
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;





@end


