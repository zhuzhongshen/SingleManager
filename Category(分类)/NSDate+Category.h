//
//  NSDate+Category.h
//  LiLian
//
//  Created by hello on 2016/11/28.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

#pragma mark - 判断时间段
- (BOOL)dateIsBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;

- (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;


@end
