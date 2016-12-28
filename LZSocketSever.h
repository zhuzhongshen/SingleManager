//
//  LZSocketSever.h
//  SocketClient
//
//  Created by hello on 2016/12/28.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AsyncSocket.h"

enum{
    SocketOfflineByServer,      //服务器掉线
    SocketOfflineByUser,        //用户断开
    SocketOfflineByWifiCut,     //wifi 断开
};


@interface LZSocketSever : NSObject<AsyncSocketDelegate>

@property(nonatomic,strong)AsyncSocket * socket;
@property (nonatomic, retain)NSTimer  *heartTimer;   // 心跳计时器

+ (LZSocketSever *)shareSocketSever;

//socket连接
- (void)startConnectSocket;

//断开socket连接
- (void)cutOffSocket;

//发送消息
- (void)sendMessage:(id)message;

@end
