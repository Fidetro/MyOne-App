//
//  FIQuestionContent.h
//  working
//
//  Created by ios-28 on 16/3/26.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FIQuestionContent : NSObject
/** sEditor **/
@property(nonatomic,copy)NSString *sEditor;
/** sWebLk **/
@property(nonatomic,copy)NSString *sWebLk;
/** strDayDiffer **/
@property(nonatomic,copy)NSString *strDayDiffer;
/** strLastUpdateDate **/
@property(nonatomic,copy)NSString *strLastUpdateDate;

/** strPraiseNumber **/
@property(nonatomic,copy)NSString *strPraiseNumber;
/** strQuestionId **/
@property(nonatomic,copy)NSString *strQuestionId;
/** strQuestionMarketTime **/
@property(nonatomic,copy)NSString *strQuestionMarketTime;
/** 问题标题 **/
@property(nonatomic,copy)NSString *strQuestionTitle;
/** 问题内容 **/
@property(nonatomic,copy)NSString *strQuestionContent;
/** 回答标题 **/
@property(nonatomic,copy)NSString *strAnswerTitle;
/** 回答内容 **/
@property(nonatomic,copy)NSString *strAnswerContent;
@end
