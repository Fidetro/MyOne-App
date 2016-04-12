//
//  HomeView.h
//  working
//
//  Created by ios-28 on 16/3/6.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeView : UIView<UIScrollViewDelegate>
@property(nonatomic,strong)NSTimer *scrollTimer;

- (id)initWithFrameRect:(CGRect)rect scrollArray:(NSArray *)array needTitle:(BOOL)isNeedTitle;
@end
