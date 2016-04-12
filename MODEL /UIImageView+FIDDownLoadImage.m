//
//  UIImageView+FIDDownLoadImage.m
//  FIDDownLoadImage
//
//  Created by Fidetro on 16/4/4.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import "UIImageView+FIDDownLoadImage.h"



@implementation UIImageView (FIDDownLoadImage)
static NSMutableDictionary *RAMdict;
static NSMutableDictionary *operationDic;
+ (void)initialize
{
    RAMdict = [NSMutableDictionary dictionary];
    
    operationDic = [NSMutableDictionary dictionary];
}
- (void)setFIDdownloadImageTaskURLWithString:(NSString *)urlString placeholderImage:(UIImage *)defaultImage{
    NSFileManager *fm = [NSFileManager defaultManager];
    self.image = defaultImage;
    NSString *caches = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[urlString lastPathComponent]];
    
    
    
    if (!(RAMdict[urlString] == nil)) {
        
        self.image = RAMdict[urlString];
        NSLog(@"内存");
    }else{
        if ([fm fileExistsAtPath:caches]) {
            
            self.image = [UIImage imageWithContentsOfFile:caches];
            [RAMdict setObject:self.image forKey:urlString];
            NSLog(@"闪存");
            
        }else{
            
            //下载图片
            NSOperationQueue *queue =[[NSOperationQueue alloc]init];
            NSBlockOperation *downloadOperation = [operationDic objectForKey:urlString];
            if (!downloadOperation) {
                //创建一个操作
                downloadOperation = [NSBlockOperation blockOperationWithBlock:^{
                    NSURL *url = [NSURL URLWithString:urlString];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    if (data) {
                        UIImage *image = [UIImage imageWithData:data];
                        
                        [data writeToFile:caches atomically:YES];
                        
                        
                        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                            [RAMdict setObject:image forKey:urlString];
                            self.image = image;
                            NSLog(@"网络");
                            
                            [operationDic removeObjectForKey:urlString];
                        }];
                        
                    }
                }];
                [queue addOperation:downloadOperation];
                
                [operationDic setObject:downloadOperation forKey:urlString];
                
            }
        }
    }
}







@end
