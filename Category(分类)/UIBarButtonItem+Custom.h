//
//  UIBarButtonItem+Custom.h
//  AiTao
//
//  Created by nihao on 16/6/25.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)

//只有图片
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

//只有文字
+ (instancetype)itemWithString : (NSString *)string andFont : (UIFont *)font andTextColor : (UIColor *)textColor target:(id)target action:(SEL)action;


@end
