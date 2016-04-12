//
//  AppDelegate.m
//  working
//
//  Created by ios-28 on 16/3/1.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ReadingTableViewController.h"
#import "QuestionViewController.h"
#import "PersonTableViewController.h"
#import "Reachability.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UITabBarController *rootTabBarController = [[UITabBarController alloc] init];
    // 首页
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
//    UINavigationController *homeNavigationController = [self dsNavigationController];
    UINavigationController *homeNavigationController = [[UINavigationController alloc]init];
    [homeNavigationController setViewControllers:@[homeViewController]];
    // 文章
    ReadingTableViewController *readingTableViewController = [[ReadingTableViewController alloc] init];
//    UINavigationController *readingNavigationController = [self dsNavigationController];
     UINavigationController *readingNavigationController = [[UINavigationController alloc]init];
    [readingNavigationController setViewControllers:@[readingTableViewController]];
    // 问题
    QuestionViewController *questionViewController = [[QuestionViewController alloc] init];
//    UINavigationController *questionNavigationController = [self dsNavigationController];
    UINavigationController *questionNavigationController = [[UINavigationController alloc]init];
    [questionNavigationController setViewControllers:@[questionViewController]];
       // 个人
    UIStoryboard *loginStoryBoard = [UIStoryboard storyboardWithName:@"PersonStoryBoard" bundle:nil];
    PersonTableViewController *PersonTableViewController = [loginStoryBoard instantiateViewControllerWithIdentifier:@"PersonTableViewController"];
//    PersonTableViewController *personViewController = [[PersonTableViewController alloc] init];
//    UINavigationController *personNavigationController = [self dsNavigationController];
    UINavigationController *personNavigationController = [[UINavigationController alloc]init];
    [personNavigationController setViewControllers:@[PersonTableViewController]];
    rootTabBarController.viewControllers = @[homeNavigationController, readingNavigationController, questionNavigationController, personNavigationController];
    rootTabBarController.tabBar.tintColor = [UIColor colorWithRed:55 / 255.0 green:196 / 255.0 blue:242 / 255.0 alpha:1];
    rootTabBarController.tabBar.barTintColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    rootTabBarController.tabBar.backgroundColor = [UIColor clearColor];

    self.window = [[UIWindow alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController  =rootTabBarController;
    
    
   
    //如果已经获得发送通知的授权则创建本地通知，否则请求授权(注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }else{
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
  Reachability *reachability =  [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    [self updateInterfaceWithReachability:reachability];
    [self.window makeKeyAndVisible];

   
    return YES;
}
- (void) reachabilityChanged: (NSNotification* )note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

//处理连接改变后的情况
- (void) updateInterfaceWithReachability: (Reachability*) curReach {
    //对连接改变做出响应的处理动作。
    NetworkStatus status = [curReach currentReachabilityStatus];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"更新" object:nil userInfo:@{@"status":@(status)}];
    switch (status) {
        case NotReachable:
        {
            NSLog(@"无网络");
            UIAlertView *netAlert = [[UIAlertView alloc] initWithTitle:@"蜂窝移动数据已关闭" message:@"启用蜂窝移动数据或无线局域网来访问数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [netAlert show];
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"蜂窝移动数据已关闭" message:@"启用蜂窝移动数据或无线局域网来访问数据" preferredStyle:UIAlertControllerStyleActionSheet];
         
            
        }
            break;
            
            
            
        case ReachableViaWiFi:
            NSLog(@"WiFi");
            
            break;
            
        case ReachableViaWWAN:
            NSLog(@"WWAN");
            
            
            break;
            
    }
}

#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types!=UIUserNotificationTypeNone) {
        
        [self addLocalNotification];
    }
}

#pragma mark 进入前台后设置消息信息
-(void)applicationWillEnterForeground:(UIApplication *)application{
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
}

#pragma mark - 私有方法
#pragma mark 添加本地通知
-(void)addLocalNotification{
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:120.0];//通知触发的时间，10s以后
    notification.repeatInterval=1;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=@"我是通知"; //通知主体
    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
//    notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
//    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    
 
    
    //调用通知
    NSLog(@"通知呢");
//    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}






- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    NSLog(@"dealloc");
}



@end
