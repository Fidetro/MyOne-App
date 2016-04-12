//
//  FIMusic.h
//  working
//
//  Created by ios-28 on 16/3/28.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FIMusic : NSObject<NSCoding>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *singer;
@property(nonatomic,copy)NSString *poster;
/**
 *  歌文件的名字
 */
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,strong)NSMutableArray *allData;



//传入一个字典，将字典变成数据模型对象
-(instancetype)initWithDict:(NSDictionary *)dict;

//提供一个类方法，实现将字典转模型
+(instancetype)musicWithDict:(NSDictionary *)dict;

@end
