//
//  OSSImageUploader.m
//  OSSImsgeUpload
//
//  Created by cysu on 5/11/16.
//  Copyright © 2016 smart_small. All rights reserved.
//

#import "OSSImageUploader.h"
#import <AliyunOSSiOS/OSSService.h>
#import "Constants.h"
#import "LiLianHead.h"
#import "SFHFKeychainUtils.h"
#import "NSString+Category.h"

@implementation OSSImageUploader
static NSString *const AccessKey = @"换上你的AccessKey";
static NSString *const SecretKey = @"换上你的SecretKey";
static NSString *const BucketName = @"换上你的BucketName";
static NSString *const AliYunHost = @"oss-cn-shenzhen.aliyuncs.com";
static NSString *kTempFolder = @"temp";


+ (void)asyncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete
{
    [self uploadImages:@[image] isAsync:YES complete:complete];
}

+ (void)syncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete
{
    [self uploadImages:@[image] isAsync:NO complete:complete];
}

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    [self uploadImages:images isAsync:YES complete:complete];
}

+ (void)syncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    [self uploadImages:images isAsync:NO complete:complete];
}

+ (void)uploadImages:(NSArray<UIImage *> *)images isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    
    
    NSString * info = [SFHFKeychainUtils getPasswordForUsername:saveUserInfoUserName andServiceName:saveUserInfoServiceName error:nil];
    NSString * uid = @"";
    if (![LiLianTool isBlankString:info]) {
        NSDictionary * userDict = [info objectFromJSONString];
        if (userDict) {
            uid = [NSString stringWithFormat:@"%@",userDict[@"uid"]];
        }
    }
    
    LRLog(@"info=====%@",info);
    
    
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey                                                                                                            secretKey:SecretKey];
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:AliYunHost credentialProvider:credential];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = images.count;
    
    NSMutableArray *callBackNames = [NSMutableArray array];
    int i = 0;
    for (UIImage *image in images) {
        if (image) {
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                //任务执行
                OSSPutObjectRequest * put = [OSSPutObjectRequest new];
                put.bucketName = BucketName;
                
                //加盖时间戳
                NSDate *datenow = [NSDate date];
                NSString *timeSp = [NSString stringWithFormat:@"lilian%@%ld",uid, (long)[datenow timeIntervalSince1970]];
                
                NSString *imageName = [kTempFolder stringByAppendingPathComponent:[timeSp stringByAppendingString:@".png"]];
                
                put.objectKey = imageName;
                
                [callBackNames addObject:[NSString stringWithFormat:@"http://%@.%@/%@",BucketName,AliYunHost,[imageName URLEncodedString]]];
                NSData *data = UIImageJPEGRepresentation(image, 0.3);
                put.uploadingData = data;
                
                
                
                OSSTask * putTask = [client putObject:put];
                [putTask waitUntilFinished]; // 阻塞直到上传完成
                if (!putTask.error) {
                    NSLog(@"upload object success!");
                } else {
                    NSLog(@"upload object failed, error: %@" , putTask.error);
                }
                if (isAsync) {
                    if (image == images.lastObject) {
                        NSLog(@"upload object finished!");
                        if (complete) {
                            complete([NSArray arrayWithArray:callBackNames] ,UploadImageSuccess);
                        }
                    }
                }
            }];
            if (queue.operations.count != 0) {
                [operation addDependency:queue.operations.lastObject];
            }
            [queue addOperation:operation];
        }
        i++;
    }
    if (!isAsync) {
        [queue waitUntilAllOperationsAreFinished];
        NSLog(@"haha");
        if (complete) {
            if (complete) {
                complete([NSArray arrayWithArray:callBackNames], UploadImageSuccess);
            }
        }
    }
}


@end
