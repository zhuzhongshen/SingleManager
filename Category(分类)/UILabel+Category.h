//
//  UILabel+Category.h
//  LiLian
//
//  Created by nihao on 16/9/19.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)
/**
 *  通用设置
 *
 *  @param text  显示内容
 *  @param color 字体颜色
 *  @param font  字体大小
 */
- (void)settext:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font;

@end
