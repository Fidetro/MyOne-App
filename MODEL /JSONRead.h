//
//  JSONRead.h
//  working
//
//  Created by ios-28 on 16/3/28.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIReadPicture.h"
typedef void(^READ_BLOCK)(FIReadPicture *);
@interface JSONRead : NSObject
/** READ_BLOCK **/
@property(nonatomic,copy)READ_BLOCK read_block;

- (void)downLoadRead;
- (void)downLoadReadInlastDate;
- (void)downLoadReadBeforeInlastDate;
@end
