//
//  UIImageView+FIDDownLoadImage.h
//  FIDDownLoadImage
//
//  Created by Fidetro on 16/4/4.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FIDDownLoadImage)
- (void)setFIDdownloadImageTaskURLWithString:(NSString *)urlString placeholderImage:(UIImage *)defaultImage;
@end
