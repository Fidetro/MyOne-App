//
//  PersonTableViewController.m
//  working
//
//  Created by ios-28 on 16/3/17.
//  Copyright © 2016年 kun. All rights reserved.
//


/*
 *NSUserDefault
 *BOOL    autoLogin
 *NSString  userName
*/



#import "PersonTableViewController.h"
#import "ShowLikeViewController.h"
#import "ShowQuestionViewController.h"
@interface PersonTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *personName;

@property (weak, nonatomic) IBOutlet UIButton *headButton;


@end

@implementation PersonTableViewController
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
   
    
    if ([super initWithCoder:aDecoder]) {
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_person"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_person_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 底部导航item
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:nil tag:0];
        tabBarItem.image = deselectedImage;
        tabBarItem.selectedImage = selectedImage;
        self.tabBarItem = tabBarItem;
        self.navigationItem.title = @"个人";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated{

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
     BOOL isAutoLogin = [userDefault boolForKey:@"autoLogin"];
    NSString *name = [userDefault objectForKey:@"userName"];
       NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@headImage.png",name]];
    NSLog(@"autoLogin=%d",isAutoLogin);
    if (isAutoLogin) {
        self.personName.text = name;
        NSData *headIamgeData =   [NSData dataWithContentsOfFile:filePath];
       [self.headButton setBackgroundImage:[UIImage imageWithData:headIamgeData] forState:UIControlStateNormal];

    }else{
  
        self.personName.text =@"未登录";
        [self.headButton setBackgroundImage:[UIImage imageNamed:@"defaultUser"] forState:UIControlStateNormal];
        
    }
   
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 2) {
        [self loadPictureCaches];
        
    }else if(indexPath.row == 3){
        [self loadQuestion];
    }
}
- (void)loadPictureCaches{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *name =  [userDefault objectForKey:@"userName"];
     NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject ;
    if (name != nil) {//名字不为空，创建名字的文件夹中caches
        NSString *doucumentFilePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/Picture",name]];
        NSArray *fileNames = [fm contentsOfDirectoryAtPath:doucumentFilePath error:nil];
     
        ShowLikeViewController *showLikeVC = [[ShowLikeViewController alloc]init];
        showLikeVC.contentArray = fileNames;
        showLikeVC.contentPath = doucumentFilePath;
        showLikeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:showLikeVC animated:YES];

    }else{
        NSString *doucumentFilePath = [filePath stringByAppendingPathComponent:@"User/Picture"];
        NSArray *fileNames = [fm contentsOfDirectoryAtPath:doucumentFilePath error:nil];
    
        ShowLikeViewController *showLikeVC = [[ShowLikeViewController alloc]init];
        showLikeVC.contentArray = fileNames;
        showLikeVC.contentPath = doucumentFilePath;
        showLikeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:showLikeVC animated:YES];
        
    }

}

#pragma mark - 点击问题加载问题
- (void)loadQuestion{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *name =  [userDefault objectForKey:@"userName"];
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject ;
    if (name != nil) {//名字不为空，创建名字的文件夹中caches
        NSString *doucumentFilePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/Question",name]];
        NSArray *fileNames = [fm contentsOfDirectoryAtPath:doucumentFilePath error:nil];

        ShowLikeViewController *showLikeVC = [[ShowLikeViewController alloc]init];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *str in fileNames) {
            if (![str isEqualToString:@".DS_Store"]) {
                [arr addObject:str];
            }
        }
        showLikeVC.contentArray = arr;
        showLikeVC.contentPath = doucumentFilePath;
        showLikeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:showLikeVC animated:YES];
        
    }else{
        NSString *doucumentFilePath = [filePath stringByAppendingPathComponent:@"User/Question"];
        NSArray *fileNames = [fm contentsOfDirectoryAtPath:doucumentFilePath error:nil];

        ShowLikeViewController *showLikeVC = [[ShowLikeViewController alloc]init];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *str in fileNames) {
            if (![str isEqualToString:@".DS_Store"]) {
                [arr addObject:str];
            }
          
        }
        showLikeVC.contentArray = arr;
        showLikeVC.contentPath = doucumentFilePath;
        showLikeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:showLikeVC animated:YES];
        
    }
    
}
#pragma mark - headImageButton

- (IBAction)clickLoginOrShow:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL isAutoLogin = [userDefault boolForKey:@"autoLogin"];

    if (isAutoLogin) {
        [self performSegueWithIdentifier:@"gotoInformation" sender:self];
    }else{
        [self performSegueWithIdentifier:@"gotoLogin" sender:self];
    }
}

@end
