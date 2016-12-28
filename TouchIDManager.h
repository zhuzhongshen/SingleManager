//
//  TouchIDManager.h
//  SocketClient
//
//  Created by hello on 2016/12/28.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouchIDManager : NSObject


typedef void(^TouchIDManagerFinnishBlock)(BOOL success, NSError *error);


/**
 * 初始化方法
 *
 *  @return return 单利
 */
+ (TouchIDManager *)sharedManager;


/**
 *  手机是否可以使用touchid
 *
 *  @return YES 可以使用
 */
-(BOOL)validateCanUseTouchId;

/**
 *  手机是否支持使用TouchId
 */
@property(nonatomic,readonly,assign)BOOL canUseTouchId;

/**
 *    指纹验证解锁的主要方法
 *
 *  @param localizedFallbackTitle  指纹解锁
 *  @param localizedReason    指纹解锁弹出框副标题
 *  @param touchBlock
 */
-(void)touchIDWithlocalizedFallbackTitle:(NSString *)localizedFallbackTitle localizedReason:(NSString*)localizedReason success:(TouchIDManagerFinnishBlock) touchBlock;

  /* use
    BOOL b =  [TouchIDManager sharedManager].canUseTouchId;
    
    if (b) {
        
        [[TouchIDManager sharedManager] touchIDWithlocalizedFallbackTitle:@"123" localizedReason:@"456" success:^(BOOL success, NSError *error) {
            
        }];
        
    }
*/

@end
