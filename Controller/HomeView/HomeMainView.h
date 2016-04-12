//
//  HomeMainView.h
//  working
//
//  Created by ios-28 on 16/3/23.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeView.h"
@protocol pushTo <NSObject>
- (void)pushToInterstController;
@end

@interface HomeMainView : UIView
@property (nonatomic,strong)HomeView *myView;
@property (nonatomic,strong)UIImageView *mainView; //每日更新的图片
/** pushToDelegate **/
@property(nonatomic,weak)id<pushTo> delegate;

- initWithAddTargetView:(UIView *)targetView;
@end
