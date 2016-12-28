



//
//  UIImage+Category.m
//  LiLian
//
//  Created by nihao on 16/9/14.
//  Copyright © 2016年 smart_small. All rights reserved.
//

#import "UIImage+Category.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Constants.h"

@implementation UIImage (Category)


/**
 *  压缩图片
 *  image:将要压缩的图片   size：压缩后的尺寸
 */
- (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

+ (UIImage *)getThumbImage:(NSURL *)videoURL

{

    
    
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
    
}
//截屏
+ (UIImage*)imageByCaptureScreen {
    
    
    //     if(&UIGraphicsBeginImageContextWithOptions!=NULL)
    //    {
    //        UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size,NO,0);
    //    }
    //    else
    //    {
    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
    // }
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    for(UIWindow*window in [[UIApplication sharedApplication]windows])
    {
        if(![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            if(IsIOS7)
            {
                CGContextTranslateCTM(context,
                                      -[window bounds].size.width* [[window layer]anchorPoint].x,
                                      -[window bounds].size.height* [[window layer]anchorPoint].y);
            }
            else
            {
                CGContextTranslateCTM(context,
                                      -[window bounds].size.width* [[window layer]anchorPoint].x,
                                      -[window bounds].size.height* [[window layer]anchorPoint].y-20);
            }
            [[window layer]renderInContext:context];
            
            CGContextRestoreGState(context);
            
        }
        
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
