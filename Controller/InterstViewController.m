//
//  InterstViewController.m
//  working
//
//  Created by Fidetro on 16/4/7.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "InterstViewController.h"
#import "KBInPutView.h"
#import "FIDComment.h"
@interface InterstViewController ()<UITableViewDelegate,UITableViewDataSource,CommentButtonDelegate,UITextFieldDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) KBInPutView *commentView;
@property(nonatomic,strong) NSMutableArray *commentArray;
@end

@implementation InterstViewController

- (NSMutableArray *)commentArray{
#warning 其实不应该这样做，应该从数据库获取评论信息和用户名，放入评论model里，一条评论一个对象，所有评论放入一个数组中
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}
static NSMutableArray *commentArray;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
    [self.view addSubview:self.tableView];
   
    self.commentView = [[KBInPutView alloc]initCommentWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 60) ];
    [self.view addSubview:self.commentView];
    self.commentView.delegate = self;
    self.commentView.commentTextField.delegate = self;
}
#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - commentButton的代理方法
- (void)callBackKeyboard{

    [self.commentView.commentButton becomeFirstResponder];

}
//#pragma mark - 点击return收起键盘textField的delegate方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.commentView.commentTextField.text.length == 0) {
        return YES;
    }
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userdefault objectForKey:@"userName"];
    FIDComment *commentInfo = [[FIDComment alloc]init];
    commentInfo.userName = name;
    commentInfo.comment = self.commentView.commentTextField.text;
    [self.commentArray addObject:commentInfo];
    
    
  NSIndexPath *indexPath =   [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:1] inSection:1];
   
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [textField resignFirstResponder];
    return YES;
}



#pragma mark - tableView的delegate方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else
    return self.commentArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }else
        return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"这里应该是从网络获取的热门话题";
    }else{
      FIDComment *commentInfo =  (FIDComment *)(self.commentArray[indexPath.row]);
        cell.textLabel.text = commentInfo.comment;
        if (commentInfo.userName) cell.detailTextLabel.text =commentInfo.userName;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark ----------监听键盘的操作------------
#pragma mark - 监听键盘弹出
- (void)openKeyBoard:(NSNotification *)notification{
    NSInteger option = [notification.userInfo [UIKeyboardAnimationCurveUserInfoKey]integerValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    self.commentView.commentTextField.text =nil;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        self.commentView.commentButton.alpha = 0;
        
        self.commentView.commentTextField.alpha = 1;
        self.commentView.frame = CGRectMake(0, self.view.frame.size.height - 50 - keyboardFrame.size.height, self.view.frame.size.width, 60);
        
    } completion:nil];
}
#pragma mark - 监听键盘隐藏
- (void)closeKeyBoard:(NSNotification *)notification{
    NSInteger option = [notification.userInfo [UIKeyboardAnimationCurveUserInfoKey]integerValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        self.commentView.commentTextField.alpha = 0;
        self.commentView.commentButton.alpha = 1;
        self.commentView.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 60);
    } completion:nil];
}
#pragma mark - viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
