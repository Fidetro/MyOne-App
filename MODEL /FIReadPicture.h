//
//  FIReadPicture.h
//  working
//
//  Created by ios-28 on 16/3/28.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FIReadPicture : NSObject
/** sWebLk **/
@property(nonatomic,copy)NSString *sWebLk;
/** strAuthor **/
@property(nonatomic,copy)NSString *strAuthor;
/** strContent **/
@property(nonatomic,copy)NSString *strContent;
/** strDayDiffer **/
@property(nonatomic,copy)NSString *strDayDiffer;
/** strHpId **/
@property(nonatomic,copy)NSString *strHpId;
/** strHpTitle **/
@property(nonatomic,copy)NSString *strHpTitle;
/** strLastUpdateDate **/
@property(nonatomic,copy)NSString *strLastUpdateDate;
/** strMarketTime **/
@property(nonatomic,copy)NSString *strMarketTime;
/** 原图 **/
@property(nonatomic,copy)NSString *strOriginalImgUrl;
/** strPn **/
@property(nonatomic,copy)NSString *strPn;
/** 缩略图 **/
@property(nonatomic,copy)NSString *strThumbnailUrl;
/** wImgUrl **/
@property(nonatomic,copy)NSString *wImgUrl;
@end
