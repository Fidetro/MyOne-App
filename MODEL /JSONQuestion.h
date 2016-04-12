//
//  JSONQuestion.h
//  working
//
//  Created by ios-28 on 16/3/26.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIQuestionContent.h"
typedef void(^QUESTION_BLOCK)(FIQuestionContent *);
@interface JSONQuestion : NSObject
/** QUESTION_BLOCK **/
@property(nonatomic,copy)QUESTION_BLOCK question_block;
/** <#Description#> **/
@property(nonatomic,copy)NSString *qeq;
- (void)downLoadQuestion;
@end
