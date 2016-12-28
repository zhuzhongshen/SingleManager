
//
//  UIImageView+LZLoading.m
//  LiLian
//
//  Created by hello on 2016/11/8.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import "UIImageView+LZLoading.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (LZLoading)

- (void)loadingWithUrlString:(NSString *)url
{

    //自适应图片宽高比例
   // self.contentMode = UIViewContentModeScaleAspectFill;
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:LOADIMAGE(@"imageloading", @"jpg")];
    

}

@end
