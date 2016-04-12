//
//  HomeViewController.m
//  working
//
//  Created by ios-28 on 16/3/3.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "NSTimer+addCategory.h"
#import "HomeMainView.h"
#import "Reachability.h"
#import "InterstViewController.h"
#import "DetailHomeViewController.h"
@interface HomeViewController ()<pushTo,UIViewControllerPreviewingDelegate>
@property (nonatomic,strong)UIImageView *mainView; //每日更新的图片
@property (nonatomic,strong)HomeView *myView; //滚动视图
@property (nonatomic,strong)UIImageView *backgroundImageView;
@property(nonatomic,strong)UILabel *textLabel;//文字
@property(nonatomic,strong)UIImageView *textImageView; //文字的背景
@property(nonatomic,strong)HomeMainView *homeMainView;
@end

@implementation HomeViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 底部导航item
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil tag:0];
        tabBarItem.image = deselectedImage;
        tabBarItem.selectedImage = selectedImage;
        self.tabBarItem = tabBarItem;

      
    }
    
    return self;
}
#pragma mark - 3Dtouch代理事件
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [self showViewController:viewControllerToCommit sender:self];
}
#pragma mark - 3Dtouch的peek
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    
    if ([self.presentedViewController isKindOfClass:[DetailHomeViewController class]])
    {
        return nil;
    }else{
    
    if (![self getShouldShowRectAndIndexPathWithLocation:location withLocationView:self.homeMainView.mainView])
        return nil;
    
    previewingContext.sourceRect = self.homeMainView.mainView.frame;
    NSLog(@"%@",NSStringFromCGRect(self.homeMainView.mainView.frame));
   DetailHomeViewController  *detailVC = [[DetailHomeViewController alloc]init];
    detailVC.imageView = [[UIImageView alloc]initWithFrame:detailVC.view.frame];
    detailVC.imageView.image = self.homeMainView.mainView.image;
    [detailVC.view addSubview:detailVC.imageView];
    
    return detailVC;
        }
}


#pragma mark - 判断touch范围是不是那里面
- (BOOL)getShouldShowRectAndIndexPathWithLocation:(CGPoint)location withLocationView:(UIView *)targetView{
    return (location.x > GetViewX(targetView) && location.x < ((GetViewX(targetView))+GetViewWidth(targetView))&&location.y > GetViewY(targetView) && location.y < ((GetViewY(targetView))+GetViewHeight(targetView)) );
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeMainView = [[HomeMainView alloc]initWithAddTargetView:self.view];
    self.homeMainView.delegate = self;
      if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
      }
    NSLog(@"viewDidLoad");
    NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(play:) name:@"更新" object:nil];

}
- (void)play:(NSNotification *)noti{
    NSLog(@"%@",noti.userInfo);
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    NSLog(@"viewDidApper");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationItem.title = @"首页";


    [self.homeMainView.myView.scrollTimer resumeTimer];
    NSLog(@"计时重新开始");


    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    NSLog(@"计时停止");
    self.hidesBottomBarWhenPushed = NO;

    [self.homeMainView.myView.scrollTimer pauseTimer];
}
#pragma mark - 点击interstButton的pushTo代理方法
- (void)pushToInterstController{
            self.hidesBottomBarWhenPushed = YES;
InterstViewController *interstVC =   [[InterstViewController alloc]init];
    [self.navigationController pushViewController:interstVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
