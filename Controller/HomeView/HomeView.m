//
//  HomeView.m
//  working
//
//  Created by ios-28 on 16/3/6.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "HomeView.h"
#import "NSTimer+addCategory.h"
#import "JSONRead.h"
#import "FIObserverNetWork.h"
@interface HomeView ()
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,assign)NSUInteger pageCount;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIPageControl *pageControl;
@end
@implementation HomeView
/**
 *  scrollView
 */
- (id)initWithFrameRect:(CGRect)rect scrollArray:(NSArray *)array needTitle:(BOOL)isNeedTitle{
    
    /**
     * init scrollView
     */
    if ((self = [super initWithFrame:rect])) {
        self.userInteractionEnabled = YES;

        CGRect ViewSize = rect;
         self.pageCount = 2;
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ViewSize.size.width, ViewSize.size.height)];
        self.scrollView.contentSize = CGSizeMake(ViewSize.size.width * self.pageCount, ViewSize.size.height);
        self.scrollView.pagingEnabled = YES;
       self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.bounces = NO;

        
        
        

//        insert image 一开始图片没下载好，使用默认图片
        for (int i = 0; i < self.pageCount; i++) {
            self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ViewSize.sizeWidth * i,0, ViewSize.sizeWidth, ViewSize.sizeHeight)];
            
            [self.imageView setImage:[UIImage imageNamed:@"default_01"]];
            [self.scrollView addSubview:self.imageView];
         
        }
       


        FIObserverNetWork *observerNetWork = [[FIObserverNetWork alloc]init];
        if ([observerNetWork isCurrentReachabilityStatus]) {
              [self changeToDownLoadImageWithContentFrame:rect];
        }
//
        
        [self addSubview:self.scrollView];
        
        
        
        
//pageControl
        self.pageControl = [[UIPageControl alloc]init];
   CGSize pageSize =     [self.pageControl sizeForNumberOfPages:self.pageCount];
        self.pageControl.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);
        self.pageControl.center =CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - 20);
        self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.numberOfPages = self.pageCount;
        
        self.pageControl.userInteractionEnabled = YES;
        [self addSubview:self.pageControl];
self.scrollTimer =  [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changePageControl) userInfo:nil repeats:YES];
       
        
    }
    return self;
}


#pragma mark - 开启其他线程下载昨天和前天的图片
- (void)changeToDownLoadImageWithContentFrame:(CGRect )ViewSize{
    static  UIImage *lastImage;
    static UIImage *BeforeInlastImage;
    JSONRead *lastDay = [[JSONRead alloc]init];
    JSONRead *BeforeInlastDay = [[JSONRead alloc]init];
   

    
    if (lastImage) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, ViewSize.sizeWidth, ViewSize.sizeHeight)];
        
        [self.imageView setImage:lastImage];
        [self.scrollView addSubview:self.imageView];
    }else{
     [lastDay downLoadReadInlastDate];
    lastDay.read_block = ^(FIReadPicture *FIReadP){
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSBlockOperation *lastDayOperation =    [NSBlockOperation blockOperationWithBlock:^{
             lastImage =  [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:FIReadP.strOriginalImgUrl]]];
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, ViewSize.sizeWidth, ViewSize.sizeHeight)];
                
                [self.imageView setImage:lastImage];
                [self.scrollView addSubview:self.imageView];

            }];
        }];
        [queue addOperation:lastDayOperation];
    };
    }
    if (BeforeInlastImage) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ViewSize.sizeWidth,0, ViewSize.sizeWidth, ViewSize.sizeHeight)];
        
        [self.imageView setImage:BeforeInlastImage];
        [self.scrollView addSubview:self.imageView];
    }else{
        [BeforeInlastDay downLoadReadBeforeInlastDate];
    BeforeInlastDay.read_block = ^(FIReadPicture *FIReadP){
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        NSBlockOperation *BeforeInlastDayOperation = [NSBlockOperation blockOperationWithBlock:^{
             BeforeInlastImage =  [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:FIReadP.strOriginalImgUrl]]];
            [[NSOperationQueue  mainQueue]addOperationWithBlock:^{
                self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ViewSize.sizeWidth,0, ViewSize.sizeWidth, ViewSize.sizeHeight)];
                
                [self.imageView setImage:BeforeInlastImage];
                [self.scrollView addSubview:self.imageView];
            }];
        }];
        [queue addOperation:BeforeInlastDayOperation];
    };
    
    }
    
    
}
#pragma mark - scrollViewDidScroll调用方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    int currentPageIndex = self.scrollView.contentOffset.x / (GetViewWidth(self.scrollView)*0.5);

    
    self.pageControl.currentPage = currentPageIndex-1;

}



#pragma mark - NSTimer selector
- (void)changePageControl{

    NSInteger i = self.pageCount-1;
    if (self.pageControl.currentPage == i) {
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.scrollView.frameWidth, self.scrollView.frameHeight) animated:YES];





        
    }else{
     
             [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frameWidth, 0, self.scrollView.frameWidth, self.scrollView.frameHeight) animated:YES];


    }
}

@end
