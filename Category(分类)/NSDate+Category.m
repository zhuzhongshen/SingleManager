
//
//  NSDate+Category.m
//  LiLian
//
//  Created by hello on 2016/11/28.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

#pragma mark - 判断时间段
- (BOOL)dateIsBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
   
    
    if ([self compare:beginDate] ==NSOrderedAscending)
        return NO;
    
    if ([self compare:endDate] ==NSOrderedDescending)
        return NO;
    
    return YES;
}





- (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] ==NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] ==NSOrderedDescending)
        return NO;
    
    return YES;
}
@end
