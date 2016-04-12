//
//  FIMusic.m
//  working
//
//  Created by ios-28 on 16/3/28.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "FIMusic.h"
//*name;
//*singer;
//*poster;
@implementation FIMusic
//传入一个字典，将字典变成数据模型对象
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self =[super init]) {
        _name = dict[@"name"];
        _singer = dict[@"singer"];
        _poster = dict[@"poster"];
        _fileName = dict[@"fileName"];
    }
    return self;
}
- (NSMutableArray *)allData{
    if (!_allData) {
        _allData = [NSMutableArray array];
    }
    return _allData;
}
//提供一个类方法，实现将字典转模型
+ (instancetype)musicWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    //    [aCoder encodeObject:_name forKey:@"name"];
    //    [aCoder encodeObject:_singer forKey:@"singer"];
    //    [aCoder encodeObject:_poster forKey:@"poster"];
    [aCoder encodeObject:_allData forKey:@"allData"];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        //        _name = [aDecoder decodeObjectForKey:@"name"];
        //        _singer = [aDecoder decodeObjectForKey:@"singer"];
        //        _poster = [aDecoder decodeObjectForKey:@"poster"];
        _allData = [aDecoder decodeObjectForKey:@"allData"];
    }
    return self;
}


@end
