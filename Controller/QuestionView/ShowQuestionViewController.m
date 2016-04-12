//
//  ShowQuestionViewController.m
//  working
//
//  Created by Fidetro on 16/4/7.
//  Copyright © 2016年 kun. All rights reserved.
//





#import "ShowQuestionViewController.h"

@interface ShowQuestionViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *questionTitle;
@property (weak, nonatomic) IBOutlet UILabel *questionContent;
@property (weak, nonatomic) IBOutlet UILabel *answerContent;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ShowQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
  self.answerCon =  [self.answerCon stringByReplacingOccurrencesOfString:@"space" withString:@"\r\n\r\n\r\n"];
    self.answerContent.text = self.answerCon;
    // Do any additional setup after loading the view.
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
