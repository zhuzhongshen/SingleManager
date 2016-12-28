//
//  UIView+RectCorner.h
//  LiLian
//
//  Created by nihao on 16/9/9.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RectCorner)


- (void)setAllCornerWithCornerRadius:(CGFloat)cornerRadius andColor : (UIColor *)borderColor andLineWidth:(CGFloat)lineWidth;

- (void)setAllCornerWithCornerRadius:(CGFloat)cornerRadius andColor : (UIColor *)borderColor;


/**  获得当前viewController **/
- (UIViewController *)viewController;

- (UIViewController *)appRootViewController;

- (void)setNoneCorner;
@end
