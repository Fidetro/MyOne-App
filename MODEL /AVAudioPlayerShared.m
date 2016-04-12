//
//  AVAudioPlayerShared.m
//  working
//
//  Created by ios-28 on 16/3/25.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "AVAudioPlayerShared.h"

@implementation AVAudioPlayerShared
static AVAudioPlayerShared *_player;
- (instancetype)init{
    static dispatch_once_t onceWay;
 dispatch_once(&onceWay, ^{
     _player = [super init];
 });
    return _player;
}

+ (instancetype)sharedPlayer{
    static dispatch_once_t onceWay;
    dispatch_once(&onceWay, ^{
        _player = [[self alloc]init];
    });
    return _player;
}

//- (instancetype)initWithContentsOfURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)outError{
//    static dispatch_once_t onceWay;
//    dispatch_once(&onceWay, ^{
//        _player = [super initWithContentsOfURL:url error:outError];
//    });
//    return _player;
//}
@end
