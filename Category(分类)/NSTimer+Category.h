//
//  NSTimer+Category.h
//  LiLian
//
//  Created by hello on 2016/12/5.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Category)

/**
 *  创建一个不会造成循环引用的循环执行的Timer
 */
+ (instancetype)pltScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo;

@end
