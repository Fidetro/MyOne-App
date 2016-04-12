//
//  JSONRead.m
//  working
//
//  Created by ios-28 on 16/3/28.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "JSONRead.h"
@interface JSONRead ()
@property(nonatomic,assign)NSTimeInterval time;

@end

@implementation JSONRead

- (void)downLoadRead{
 
    NSString *dateString =  [self getDateInitNSTimeInterval:self.time * 0];
    [self downLoadReadSessionInDate:dateString];
}


- (void)downLoadReadInlastDate{
   

 NSString *dateString =  [self getDateInitNSTimeInterval:-self.time ];
       [self downLoadReadSessionInDate:dateString];
}

- (void)downLoadReadBeforeInlastDate{
    
NSString *dateString =  [self getDateInitNSTimeInterval:-self.time * 2];
    [self downLoadReadSessionInDate:dateString];
}

//抽出Date的init传入时间
- (NSString *)getDateInitNSTimeInterval:(NSTimeInterval)time{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSinceNow:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString  *dateString = [formatter stringFromDate:date];
    return dateString;
}





//抽出传入时间进行下载的session
- (void)downLoadReadSessionInDate:(NSString *)dateTime{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://211.152.49.184:7001/OneForWeb/one/getHpinfo?strDate=%@",dateTime]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        FIReadPicture *FIreadP = [[FIReadPicture alloc]init];
        [FIreadP setValuesForKeysWithDictionary:dict[@"hpEntity"]];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            READ_BLOCK myblock =  self.read_block;
            if(myblock){
            myblock(FIreadP);
            }
        }];
        
        
    }];
    [task resume];
}

- (NSTimeInterval)time{
    return 24 * 60 * 60;
}
@end
