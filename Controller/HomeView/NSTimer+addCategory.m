//
//  NSTimer+addCategory.m
//  working
//
//  Created by ios-28 on 16/3/11.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "NSTimer+addCategory.h"

@implementation NSTimer (addCategory)
-(void)pauseTimer{
    
    if (![self isValid]) {
        return ;
    }
    
    [self setFireDate:[NSDate distantFuture]]; //4001-01-01 00:00:00 +0000
    
    
}


-(void)resumeTimer{
  
    if (![self isValid]) {
        return ;
    }
    

    [self setFireDate:[NSDate date]];
    
}
@end
