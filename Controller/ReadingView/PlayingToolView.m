//
//  PlayingToolView.m
//  working
//
//  Created by ios-28 on 16/3/23.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "PlayingToolView.h"

@interface PlayingToolView ()
@property (nonatomic,strong)UIView *toolView;
@property (nonatomic,strong)UIButton *goBackButton;



@end
@implementation PlayingToolView
- (instancetype)initWithTargetView:(UIView *)targetView andFrame:(CGRect )frame{
    if ([super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];
        [self addToolViewInTargetView:targetView];
        [self setToolViewInTargetView:targetView];
        
        [self addSubview:self.toolView];
        [self.toolView addSubview:self.nextButton];
        [self.toolView addSubview:self.previousButton];
        [self.toolView addSubview:self.playOrPauseButton];
        [self.toolView addSubview:self.progressSlider];
        [self.toolView addSubview:self.goBackButton];
       
    

    }
    return self;
}


#pragma mark - 设置控件大小
- (void)addToolViewInTargetView:(UIView *)targetView{
    self.toolView = [[UIButton alloc]initWithFrame:self.bounds];
    self.goBackButton = [[UIButton alloc]initWithFrame:CGRectMake(GetViewWidth(self.toolView)-60, 10, 50, 50)];
    self.progressSlider = [[UISlider alloc]initWithFrame:CGRectMake(GetViewWidth(self.toolView) * 0.1, GetViewHeight(self.toolView) * 0.2, 250, 10)];
    self.previousButton = [[UIButton alloc]initWithFrame:CGRectMake(GetViewWidth(self.toolView) * 0.15, GetViewHeight(self.toolView) * 0.5, 50, 50)];
    self.playOrPauseButton = [[UIButton alloc]initWithFrame:CGRectMake(GetViewWidth(self.toolView) * 0.35, GetViewHeight(self.toolView) * 0.5, 50, 50)];
    self.nextButton = [[UIButton alloc]initWithFrame:CGRectMake(GetViewWidth(self.toolView) * 0.55, GetViewHeight(self.toolView) * 0.5, 50, 50)];
   
    

}

#pragma mark - 控件的set方法
- (void)setToolViewInTargetView:(UIView *)targetView{
    
//    playOrPauseButton;
//    nextButton;
//    previousButton;
//    *progressSlider;
    
#warning 关闭了进度条的控制
//    self.progressSlider.enabled = NO;
    
    [self.goBackButton setBackgroundImage:[UIImage imageNamed:@"miniplayer_btn_playlist_close"] forState:UIControlStateNormal];
    
    [self.goBackButton addTarget:self action:@selector(goHide) forControlEvents:UIControlEventTouchDown];
    
    [self.previousButton setBackgroundImage:[UIImage imageNamed:@"player_btn_pre_normal"] forState:UIControlStateNormal];
    
    [self.playOrPauseButton setBackgroundImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
    
    [self.playOrPauseButton setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateSelected];
    

    
    
    [self.nextButton setBackgroundImage:[UIImage imageNamed:@"player_btn_next_normal"] forState:UIControlStateNormal];
    
}


- (void)goHide{
    NSLog(@"播放界面隐藏了");
    [self.delegate moveView]; //让控制器去完成toolview的移动

}
//- (void)dealloc{
//    NSLog(@"%@",self.toolView);
//    NSLog(@"%@",self.goBackButton);
//}

@end