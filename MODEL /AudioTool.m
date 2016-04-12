//
//  AudioTool.m
//  working
//
//  Created by ios-28 on 16/3/24.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "AudioTool.h"
#import "AVAudioPlayerShared.h"

@interface AudioTool ()


@end

@implementation AudioTool

static AVAudioPlayer *_player;

//准备唯一的一个字典属性，记录音乐的player对象
static NSMutableDictionary *_players;

//使用类时，执行一次
+ (void)initialize
{
    _players = [NSMutableDictionary dictionary];
}

+ (AVAudioPlayer *)playMusicWithName:(NSString *)musicName{
    
    if (_player) {//如果有在放的歌，停止
          [_player pause];
    }
        _player = nil;
    _player = _players[musicName];
    if (_player == nil) {
      
        NSURL *url = [[NSBundle mainBundle]URLForResource:musicName withExtension:nil];
        if(url == nil)return nil;
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];;
        [_players setObject:_player forKey:musicName];
        [_player prepareToPlay];
        
    }
   
 
    [_player play];
    return _player;
    
    
}






//不是在AVAudioPlayer类的时候不能这样写
//+ (instancetype)sharedPlayer{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _player = [[self alloc]init];
//    });
//    return _player;
//}


@end
