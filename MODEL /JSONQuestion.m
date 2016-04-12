//
//  JSONQuestion.m
//  working
//
//  Created by ios-28 on 16/3/26.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "JSONQuestion.h"
#pragma mark - quq传进block，让block去改变person的labeltext

@implementation JSONQuestion
- (void)downLoadQuestion{
    NSDate *date = [NSDate date];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString  *dateString = [formatter stringFromDate:date];
    NSLog(@"%@",dateString);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://211.152.49.184:7001/OneForWeb/one/getOneQuestionInfo?strDate=%@",dateString]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
        FIQuestionContent *quq =[[FIQuestionContent alloc]init];
        [quq setValuesForKeysWithDictionary:dict[@"questionAdEntity"]];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
      
            QUESTION_BLOCK myblock =  self.question_block;
            if(myblock){
                myblock(quq);
            }
        }];
        
        NSLog(@"%@",quq.strQuestionId);
    }];

    [task  resume];
 
}
@end
