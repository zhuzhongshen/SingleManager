//
//  UIImage+Category.h
//  LiLian
//
//  Created by nihao on 16/9/14.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)


/**
 *  压缩图片
 *  image:将要压缩的图片   size：压缩后的尺寸
 */
- (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (UIImage *)getThumbImage:(NSURL *)videoURL;

+ (UIImage*)imageByCaptureScreen;


@end
