//
//  UITextField+Margin.m
//  LiLian
//
//  Created by nihao on 16/9/9.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import "UITextField+Margin.h"
#import "UIColor+Hex.h"
#import <objc/runtime.h>
static NSString *kLimitTextMaxLengthKey = @"kLimitTextMaxLengthKey";
static NSString *kLimitTextErrorMessageKey = @"kLimitTextErrorMessageKey";



@interface UITextField()

/**
 *  要在Category中扩展的属性
 */
@property(nonatomic,assign)NSInteger marginLeftWidth;

@end

static const void *leftMarginKey = &leftMarginKey;

@implementation UITextField (Margin)


- (void)setMarginLeftWidth:(NSInteger)marginLeftWidth
{
    objc_setAssociatedObject(self, leftMarginKey, [NSNumber numberWithInteger:marginLeftWidth], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)marginLeftWidth{
    
    NSNumber *leftWidth = objc_getAssociatedObject(self, leftMarginKey);
    if (! leftWidth)
    {
        return 0;
    }
    else
    {
        return [leftWidth integerValue];
    }
    
}

- (void)marginforleftWidth:(CGFloat)leftWidth andMarginImageNamed : (NSString *)imageNmaed andBackImage:(UIImage *)bgImage{
    
    
    self.marginLeftWidth = leftWidth;
    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, self.bounds.size.height)];
    
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageNmaed] forState:UIControlStateNormal];
    [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
    
    [btn setFrame:leftview.bounds];
    [btn setAdjustsImageWhenHighlighted:NO];
    [leftview addSubview:btn];
    
}

- (void)marginforLeftEmptyWidth:(CGFloat)leftWidth andLeftMargin:(CGFloat)leftMargin{
    
    self.marginLeftWidth = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, self.bounds.size.height)];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
    
    UILabel * label =  [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.text = @"+86";
    label.frame = CGRectMake(leftMargin, 0, leftview.bounds.size.width-leftMargin, leftview.bounds.size.height);
    [leftview addSubview:label];
    
    
}


- (void)marginforLeftEmptyWidth:(CGFloat)leftWidth{
    self.marginLeftWidth = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, self.bounds.size.height)];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

//left 间距
- (void)marginforleftWidth:(CGFloat)leftWidth andMarginImageNamed : (NSString *)imageNmaed
{
    self.marginLeftWidth = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, self.bounds.size.height)];
    
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageNmaed] forState:UIControlStateNormal];
    [btn setFrame:leftview.bounds];
    [btn setAdjustsImageWhenHighlighted:NO];
    [leftview addSubview:btn];
}

//- (CGRect)textRectForBounds:(CGRect)bounds
//{
//    
//    
//    
//    bounds.origin.x += self.marginLeftWidth;
//    
//    return  bounds;
//    
//}
//// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    bounds.origin.x += self.marginLeftWidth;
//    
//    return  bounds;
//    //    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
//    //    return inset;
//}




-(void)resetTextfieldValidation
{
    objc_setAssociatedObject(self, (__bridge  const void *)(kLimitTextErrorMessageKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setValidationType:(ValidationType)validationType
{
    [self addTarget:self action:@selector(resetTextfieldValidation) forControlEvents:UIControlEventEditingDidBegin];
    self.keyboardType = UIKeyboardTypeDefault;
    
    if (validationType == VALIDATION_TYPE_NUM_VALIDATED) {
        [self limitTextOnlyNumber];
        self.keyboardType = UIKeyboardTypeNumberPad;
    }else if(validationType == VALIDATION_TYPE_EMAIL_VALIDATED){
        [self limitTextOnlyEmail];
        self.keyboardType = UIKeyboardTypeEmailAddress;
    }else if(validationType == VALIDATION_TYPE_MOBILE_PHONE_VALIDATED){
        [self limitTextOnlyPhone];
        self.keyboardType = UIKeyboardTypePhonePad;
    }else if(validationType == VALIDATION_TYPE_ID_CARD_VALIDATED){
        [self limitTextOnlyIDCard];
    }else if (validationType == VALIDATION_TYPE_PASSWORD_VALIDATED)
    {
        
        [self limitTextOnlyPassword];
        self.secureTextEntry = YES;
        
    }else if (validationType == VALIDATION_TYPE_NICKNAME_VALIDATED)
    {
        [self limitTextOnlyNickName];
    }
    
    [self limitTextNoSpace];
}

-(NSString *)errorMessage
{
    NSString *str= objc_getAssociatedObject(self, (__bridge  const void *)(kLimitTextErrorMessageKey));
    if (str) {
        return str;
    }
    return nil;
}

#pragma mark - Limit Text Length
- (void)limitTextLength:(int)length
{
    objc_setAssociatedObject(self, (__bridge  const void *)(kLimitTextMaxLengthKey), [NSNumber numberWithInt:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldTextLengthLimit:(id)sender
{
    NSNumber *maxLengthNumber = objc_getAssociatedObject(self, (__bridge  const void *)(kLimitTextMaxLengthKey));
    int maxLength = [maxLengthNumber intValue];
    if(self.text.length > maxLength){
        self.text = [self.text substringToIndex:maxLength];
    }
}



#pragma mark - Limit Text Only Number
-(void)limitTextOnlyNumber
{
    [self addTarget:self action:@selector(textFieldTextNumberLimit:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldTextNumberLimit:(id)sender
{
    if (!self.text.length) {
        [self resetTextfieldValidation];
        return;
    }
    NSString * regexNum = @"^\\d*$";
    NSPredicate *regexNumPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexNum];
    if ([regexNumPredicate evaluateWithObject:self.text]==YES) {
        
        
    }else{
        
        
        self.text=[self.text substringFromIndex:self.text.length];
    }
}
#pragma mark - Limit  Text Only Password
- (void)limitTextOnlyPassword
{
    
    [self addTarget:self action:@selector(textFieldTextPasswordLimit:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self limitTextOnlyEffective];
    
}
#pragma 正则匹配用户密码6-18位数字和字母组合
- (void)textFieldTextPasswordLimit:(id)sender
{
    
    
    if (!self.text.length) {
        [self resetTextfieldValidation];
        return;
    }
    
    
    
    
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if ([regexPredicate evaluateWithObject:self.text]==YES) {
        
        
        
        [self resetTextfieldValidation];
    }else{
        
        
        
        objc_setAssociatedObject(self, (__bridge  const void *)(kLimitTextErrorMessageKey), @"密码格式错误", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}

#pragma mark - Limit text Only Effective (特殊字符处理)
- (void)limitTextOnlyEffective{
    [self addTarget:self action:@selector(textFieldTextEffectiveLimit:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldTextEffectiveLimit:(id)sender
{
    if (!self.text.length) {
        [self resetTextfieldValidation];
        return;
    }
    
    
    //NSString * regexNum = @".*[-`=\\\[\\];',./~!@#$¥%^&*()_+|{}:\"<>?]+.*€•";
    
    NSString * regex = @"^[a-zA-Z0-9]{1,20}$";
    
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([regexPredicate evaluateWithObject:self.text]==YES) {
        
        
        
        
        
        
    }else{
        //删除最后一个字符
        self.text = [self.text substringToIndex: [self.text length]-1];
        
        
        
    }
}

#pragma mark - Limit Text Only NickName
- (void)limitTextOnlyNickName
{
    [self addTarget:self action:@selector(textFieldTextNickNameLimit:) forControlEvents:UIControlEventEditingChanged];
    
}
- (void)textFieldTextNickNameLimit: (id)sender
{
    if (!self.text.length) {
        [self resetTextfieldValidation];
        return;
    }
    
    NSString * regex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([regexPredicate evaluateWithObject:self.text]==YES) {
        
        [self resetTextfieldValidation];
    }else{
        
        objc_setAssociatedObject(self, (__bridge  const void *)(kLimitTextErrorMessageKey), @"昵称格式错误", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
#pragma mark - Limit Text Only Phone
-(void)limitTextOnlyPhone
{
    [self addTarget:self action:@selector(textFieldTextPhoneLimit:) forControlEvents:UIControlEventEditingDidEnd];
    [self limitTextLength:11];
    [self limitTextOnlyNumber];
}

- (void)textFieldTextPhoneLimit:(id)sender
{
    if (!self.text.length) {
        [self resetTextfieldValidation];
        return;
    }
    NSString * regex=@"^1\\d{10}$";
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([regexPredicate evaluateWithObject:self.text]==YES) {
        self.text=[self.text substringToIndex:self.text.length];
        [self resetTextfieldValidation];
    }else{
        self.text=[self.text substringToIndex:self.text.length];
        objc_setAssociatedObject(self, (__bridge  const void *)(kLimitTextErrorMessageKey), @"请输入正确的手机号码", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
#pragma mark - Limit Text For Email
-(void)limitTextOnlyEmail
{
    [self addTarget:self action:@selector(textFieldTextForEmailLimit:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textFieldTextForEmailLimit:(id)sender
{
    if (!self.text.length) {
        [self resetTextfieldValidation];
        return;
    }
    NSString *regex=@"^[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]\\.[a-zA-Z][a-zA-Z\\.]*[a-zA-Z]$";
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([regexPredicate evaluateWithObject:self.text]==YES) {
        
        
        [self resetTextfieldValidation];
    }else{
        
        
        
        objc_setAssociatedObject(self, (__bridge  const void *)(kLimitTextErrorMessageKey), @"邮箱格式错误", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
#pragma mark - Limit Text For IDCard
-(void)limitTextOnlyIDCard
{
    [self addTarget:self action:@selector(textFieldTextForIDCardLimit:) forControlEvents:UIControlEventEditingDidEnd];
    [self limitTextLength:18];
}

- (void)textFieldTextForIDCardLimit:(id)sender
{
    if (!self.text.length) {
        [self resetTextfieldValidation];
        return;
    }
    //NSString *regex=@"^(4\\d{12}(?:\\d{3})?)$";
    NSString *regex=@"^([1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3})|([1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X))$";
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([regexPredicate evaluateWithObject:self.text]==YES) {
        [self resetTextfieldValidation];
    }else{
        objc_setAssociatedObject(self, (__bridge  const void *)(kLimitTextErrorMessageKey), @"身份证格式错误", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - Limit Text NoSpace
- (void)limitTextNoSpace
{
    [self addTarget:self action:@selector(textFieldTextNoSpaceLimit:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textFieldTextNoSpaceLimit:(id)sender
{
    self.text = [self noSpaceString:self.text];
}
- (NSString *)noSpaceString:(NSString *)str
{
    if (str.length) {
        return  [str stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    }
    
    return str;
}


@end
