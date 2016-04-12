//
//  ShowLikeViewController.m
//  working
//
//  Created by Fidetro on 16/4/6.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "ShowLikeViewController.h"
#import "FIDReadingCell.h"
#import "ShowQuestionViewController.h"
@interface ShowLikeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ShowLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",[self.contentPath lastPathComponent]);
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if ([[self.contentPath lastPathComponent] isEqualToString:@"Picture"]) {
        UILabel *label = [[UILabel alloc]init];
        UIImageView *imageView= [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[self.contentPath stringByAppendingPathComponent:self.contentArray[indexPath.row]]]];
       
        label.text = self.contentArray[indexPath.row];
        FIDReadingCell *cell = [[FIDReadingCell alloc]setCellInTableViewDefault1InTableView:tableView CellHeight:100 AddImageView:imageView AddFirstLabel:label reuseIdentifier:@"cell"];
        return cell;
    }else if([[self.contentPath lastPathComponent] isEqualToString:@"Question"]){
       NSLog(@"%@",self.contentArray[indexPath.row]);
     
        cell.textLabel.text = self.contentArray[indexPath.row];
        return cell;
    }
   

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   if([[self.contentPath lastPathComponent] isEqualToString:@"Question"]){
       UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ShowQuestionStoryBoard" bundle:nil];
    if ([ [sb instantiateInitialViewController] isKindOfClass:[ShowQuestionViewController class]]) {
   ShowQuestionViewController *showQuestionVC =  [sb instantiateInitialViewController];
                   showQuestionVC.hidesBottomBarWhenPushed = YES;
        showQuestionVC.answerCon =[NSString stringWithContentsOfFile:[self.contentPath stringByAppendingPathComponent:self.contentArray[indexPath.row]] encoding:NSUTF8StringEncoding error:nil];
                   [self.navigationController pushViewController:showQuestionVC animated:YES];
               }
   }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
