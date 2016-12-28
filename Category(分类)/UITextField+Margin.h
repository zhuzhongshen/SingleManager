//
//  UITextField+Margin.h
//  LiLian
//
//  Created by nihao on 16/9/9.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    VALIDATION_TYPE_NUM_VALIDATED = 0,//数字
    VALIDATION_TYPE_ID_CARD_VALIDATED = 1,//身份证
    VALIDATION_TYPE_MOBILE_PHONE_VALIDATED = 2,//手机号
    VALIDATION_TYPE_EMAIL_VALIDATED = 3,//email
    VALIDATION_TYPE_PASSWORD_VALIDATED = 4,//密码
    VALIDATION_TYPE_NICKNAME_VALIDATED = 5,//用户名
}ValidationType;


@interface UITextField (Margin)

- (void)marginforleftWidth:(CGFloat)leftWidth andMarginImageNamed : (NSString *)imageNmaed andBackImage:(UIImage *)bgImage;
//left 间距
- (void)marginforleftWidth:(CGFloat)leftWidth andMarginImageNamed : (NSString *)imageNmaed;

- (void)marginforLeftEmptyWidth:(CGFloat)leftWidth;
//
- (void)marginforLeftEmptyWidth:(CGFloat)leftWidth andLeftMargin:(CGFloat)leftMargin;

//设置类型
-(void)setValidationType:(ValidationType)validationType;

- (NSString *)errorMessage;

- (void)limitTextLength:(int)length;


@end
