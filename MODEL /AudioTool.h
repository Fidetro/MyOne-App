//
//  AudioTool.h
//  working
//
//  Created by ios-28 on 16/3/24.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface AudioTool : NSObject
// 播放音乐 musicName:音乐的名称
+(AVAudioPlayer *)playMusicWithName:(NSString *)musicName;


@end
