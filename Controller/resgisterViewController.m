//
//  resgisterViewController.m
//  working
//
//  Created by ios-28 on 16/3/17.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "resgisterViewController.h"

@interface resgisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *resgisterName;
@property (weak, nonatomic) IBOutlet UITextField *resgisterPwd;
@property (weak, nonatomic) IBOutlet UITextField *resgisterEmail;

@end

@implementation resgisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
 }

- (IBAction)enterToLogin:(id)sender {
    if (self.resgisterName.text.length > 0&& self.resgisterPwd.text.length > 0 ) {
        NSString *name = self.resgisterName.text;
        NSString *pwd =self.resgisterPwd.text;
        NSString *Email = self.resgisterEmail.text;
        NSDictionary *dict = @{
                               @"name":name,
                               @"pwd":pwd,
                               @"Email":Email
                               };
        
        /**
         *  存进coredata里面，不应该存进plist里
         */
        
     
        [self  writeToplist:dict];
        
        [self performSegueWithIdentifier:@"enterResgister" sender:self];

    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"账号或者密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.resgisterName.text = nil;
            self.resgisterPwd.text = nil;
            self.resgisterEmail.text = nil;
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (void)writeToplist:(NSDictionary *)dict{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"user.plist"];
    NSLog(@"%@",filePath);
    
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:filePath];
     NSMutableArray *muArray = [NSMutableArray array];
    if (arr) {
         muArray = arr ;
    }
 
   
   
   
    [muArray addObject:dict];
    [muArray writeToFile:filePath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
