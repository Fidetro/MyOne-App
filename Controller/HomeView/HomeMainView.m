//
//  HomeMainView.m
//  working
//
//  Created by ios-28 on 16/3/23.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "HomeMainView.h"
#import "JSONRead.h"
#import "FIObserverNetWork.h"

@interface HomeMainView ()

 //滚动视图
@property (nonatomic,strong)UIImageView *backgroundImageView;
@property(nonatomic,strong)UILabel *textLabel;//文字
@property(nonatomic,strong)UIImageView *textImageView; //文字的背景
@end
@implementation HomeMainView

- (instancetype)initWithAddTargetView:(UIView *)targetView{
    if ([super init]) {
        targetView.backgroundColor = [UIColor whiteColor];
        [self addnavigationViewInTargetView:(UIView *)targetView];
        
        
        self.myView = [[HomeView alloc]initWithFrameRect:CGRectMake(0, 44,targetView.boundsWidth , targetView.boundsHeight * 0.3) scrollArray:nil needTitle:NO];
        self.frame = self.myView.frame;
        self.myView.backgroundColor = [UIColor redColor];
        [targetView addSubview:self.myView];
        
        
        
        [self addMainViewInTargetView:targetView];
         self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,GetViewHeight(targetView) - GetViewHeight(targetView) * 0.3 +44, GetViewWidth(targetView),GetViewHeight(targetView) * 0.2 - tabbarHeight+25)];
       
//        [targetView addSubview: self.textLabel ];
        [self addInterestViewInTargetView:targetView];
        
        
    }
    return self;
}
- (void)addnavigationViewInTargetView:(UIView *)targetView{
    
    UIView *navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, targetView.boundsWidth, 44)];

    [targetView addSubview:navigationView];
}

#pragma mark - 中间的图片
- (void)addMainViewInTargetView:(UIView *)targetView{
    
    
    self.mainView =[[UIImageView alloc]initWithFrame:CGRectMake(5, self.myView.frameY +self.myView.frame.size.height+10,targetView.boundsWidth-15 , targetView.boundsHeight * 0.4-20)];

  
    self.mainView.image = [UIImage imageNamed:@"backgroudImage"];
    self.mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainView.layer.shadowOffset = CGSizeMake(6, 6);
    self.mainView.layer.shadowOpacity = 0.8;
    self.mainView.layer.shadowRadius = 4;
    
      static UIImage *image;
    JSONRead *jsonRead = [JSONRead new];
    if (image) {
         self.mainView.image = image;
    }else{
    

        FIObserverNetWork *observerNetWork = [[FIObserverNetWork alloc]init];
        
        if ([observerNetWork isCurrentReachabilityStatus]) {
            [jsonRead downLoadRead];
            jsonRead.read_block = ^(FIReadPicture *FIReadP){
                
                dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_async(queue, ^{
                    image =  [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:FIReadP.strOriginalImgUrl]]];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        self.mainView.image = image;
                    });
                });
                
            };
        }
 
    }
    
    
    [targetView addSubview:self.mainView];
    
    
}
- (void)setTextLabel:(UILabel *)textLabel{
        JSONRead *jsonRead = [JSONRead new];
    _textLabel = textLabel;
    _textLabel.numberOfLines = 0;
    FIObserverNetWork *observerNetWork = [[FIObserverNetWork alloc]init];
    __block NSString *str;
    if ([observerNetWork isCurrentReachabilityStatus]) {
        [jsonRead downLoadRead];
        jsonRead.read_block = ^(FIReadPicture *FIReadP){
            
            dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                str =  [FIReadP.strContent stringByAppendingString:[NSString stringWithFormat:@"    %@",FIReadP.strAuthor]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.textLabel.text = str;
                });
            });
            
        };
    }
 
}

#pragma mark - 话题View
- (void)addInterestViewInTargetView:(UIView *)targetView{
    
    
    
    
    /**
     init
     */
    UIImageView *moreView = [[UIImageView alloc]initWithFrame:CGRectMake(0,GetViewHeight(targetView) - GetViewHeight(targetView) * 0.3 +44, GetViewWidth(targetView),GetViewHeight(targetView) * 0.2 - tabbarHeight+25)];
    
    
    UIButton *interestLeftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,GetViewHeight(moreView) * 0.4, GetViewWidth(targetView) * 0.5-5, GetViewHeight(moreView) * 0.6)];
    
    UIButton *interestRightButton = [[UIButton alloc]initWithFrame:CGRectMake(GetViewWidth(interestLeftButton) + 5,GetViewHeight(moreView) * 0.4, GetViewWidth(targetView) * 0.5, GetViewHeight(moreView) * 0.6)];
    
    UILabel *hotTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, GetViewHeight(moreView) - GetViewHeight(interestLeftButton))];
    
    UIButton  *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(GetViewWidth(targetView) - 50, 0, 30, GetViewHeight(moreView) - GetViewHeight(interestLeftButton))];
    
    /**
     *  moreView set
     */
    moreView.backgroundColor = [UIColor grayColor];
    moreView.userInteractionEnabled = YES;
    
    /**
     *  moreButton set
     */
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    moreButton.titleLabel.font =[UIFont systemFontOfSize:15];
    /**
     *  hotTitle set
     */
    hotTitle.text  = @"热门话题";
    hotTitle.font =  [UIFont systemFontOfSize:15];
    hotTitle.textColor = [UIColor whiteColor];
    
    
    /**
     *  interestButton set
     */
    
    
    
    [interestLeftButton setTitle:@"#话题1#" forState:UIControlStateNormal];//没有第二行内容
    [interestRightButton setTitle:@"#话题2#" forState:UIControlStateNormal];
    [interestLeftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [interestRightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    interestLeftButton.backgroundColor = [UIColor whiteColor];
    interestRightButton.backgroundColor = [UIColor whiteColor];
    [interestLeftButton addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [interestRightButton addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    
    interestLeftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//button文字向右
    interestRightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    interestLeftButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);//使文字距离做边框保持10个像素的距离。
    interestRightButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    

    
    
    
    
    
    [moreView addSubview:moreButton];
    [moreView addSubview:hotTitle];
    [moreView addSubview:interestLeftButton];
    [moreView addSubview:interestRightButton];
    [targetView addSubview:moreView];
    
}
-(void)go{
    [self.delegate pushToInterstController];
}
@end