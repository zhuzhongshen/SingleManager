//
//  UIBarButtonItem+Custom.m
//  AiTao
//
//  Created by nihao on 16/6/25.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"
#import "LiLianHead.h"

@implementation UIBarButtonItem (Custom)

//注意此处必须要传递 target:(id)target ，从来指明目标对象
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithString : (NSString *)string andFont : (UIFont *)font andTextColor : (UIColor *)textColor target:(id)target action:(SEL)action

{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:string forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.size = [button.titleLabel.text sizeWithFont:font maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 44)];
    button.titleLabel.font = font;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:button];
}



@end
