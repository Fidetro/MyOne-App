//
//  PlayingToolView.h
//  working
//
//  Created by ios-28 on 16/3/23.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol moveView <NSObject>
- (void)moveView;
@end
@interface PlayingToolView : UIView
/**
 *  move_delegate
 */
@property(nonatomic,weak)id<moveView> delegate;
@property (nonatomic,strong)UIButton *playOrPauseButton;
@property (nonatomic,strong) UISlider *progressSlider;
@property (nonatomic,strong)UIButton *nextButton;
@property (nonatomic,strong)UIButton *previousButton;
- (instancetype)initWithTargetView:(UIView *)targetView andFrame:(CGRect )frame;
@end
