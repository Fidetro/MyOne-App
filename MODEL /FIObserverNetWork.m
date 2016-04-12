//
//  FIObserverNetWork.m
//  working
//
//  Created by ios-28 on 16/4/1.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "FIObserverNetWork.h"

@implementation FIObserverNetWork
- (NSInteger)isCurrentReachabilityStatus{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    Reachability *reachability =  [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
 return    [self updateInterfaceWithReachability:reachability];
    
}
- (void) reachabilityChanged: (NSNotification* )note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

//处理连接改变后的情况
- (NSInteger) updateInterfaceWithReachability: (Reachability*) curReach {
    //对连接改变做出响应的处理动作。
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    switch (status) {
        case NotReachable:
        {
            NSLog(@"无网络");
        }
            break;
            
            
            
        case ReachableViaWiFi:
            NSLog(@"WiFi");
            
            break;
            
        case ReachableViaWWAN:
            NSLog(@"WWAN");
            
            
            break;
            
    }
    return status;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    NSLog(@"dealloc");
}


@end
