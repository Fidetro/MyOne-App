//
//  LoginViewController.m
//  working
//
//  Created by ios-28 on 16/3/17.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "LoginViewController.h"
#import "InformationTableViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;

@end

@implementation LoginViewController
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ( [super initWithCoder:aDecoder]) {
        self.hidesBottomBarWhenPushed = YES;
        self.navigationItem.title = @"登录";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 [self.userPwd setSecureTextEntry:YES];
}
- (IBAction)enterInfor:(id)sender {
    
 
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"user.plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dic in arr) {
        if ([dic[@"name"] isEqualToString:self.userName.text] &[dic[@"pwd"] isEqualToString:self.userPwd.text]) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
       
            [userDefault setBool:YES forKey:@"autoLogin"];
            [userDefault setObject:self.userName.text forKey:@"userName"];
         
            
            
            [self performSegueWithIdentifier:@"LoginToInformation" sender:self];
            return ;
        }
    }

    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"用户不存在或者密码错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    
    

  }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
