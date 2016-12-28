






//
//  UIView+RectCorner.m
//  LiLian
//
//  Created by nihao on 16/9/9.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import "UIView+RectCorner.h"

@implementation UIView (RectCorner)

- (void)setAllCornerWithCornerRadius:(CGFloat)cornerRadius andColor : (UIColor *)borderColor andLineWidth:(CGFloat)lineWidth{
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                          cornerRadius:cornerRadius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    CAShapeLayer *borderLayer=[CAShapeLayer layer];
    borderLayer.path    =   maskPath.CGPath;
    borderLayer.fillColor  = [UIColor clearColor].CGColor;
    borderLayer.strokeColor    = borderColor.CGColor;
    borderLayer.lineWidth      = lineWidth;
    borderLayer.frame =  self.layer.bounds;
    [ self.layer addSublayer:borderLayer];

}


- (void)setAllCornerWithCornerRadius:(CGFloat)cornerRadius andColor : (UIColor *)borderColor{
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                          cornerRadius:cornerRadius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    CAShapeLayer *borderLayer=[CAShapeLayer layer];
    borderLayer.path    =   maskPath.CGPath;
    borderLayer.fillColor  = [UIColor clearColor].CGColor;
    borderLayer.strokeColor    = borderColor.CGColor;
    borderLayer.lineWidth      = 1.0;
    borderLayer.frame =  self.layer.bounds;
    [ self.layer addSublayer:borderLayer];
    
}
- (void)setCornerOnTop {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}
- (void)setCornerOnBottom {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
   
}
- (void)setAllCorner {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                          cornerRadius:10.0];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}
- (void)setNoneCorner{
    
    self.layer.mask = nil;

}


- (UIViewController *)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


@end
