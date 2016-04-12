//
//  QuestionViewController.m
//  working
//
//  Created by ios-28 on 16/3/3.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "QuestionViewController.h"
#import "JSONQuestion.h"
#import "FIObserverNetWork.h"
@interface QuestionViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIImageView *questionImageView;
@property(nonatomic,strong) UILabel *questionTitleLabel; //问题标题
@property(nonatomic,strong) UILabel *questionContentLabel;//问题内容

@property(nonatomic,strong) UILabel *respondContentLabel; //回答内容
@property(nonatomic,strong) UIImageView *lineImageView;
@property(nonatomic,strong) UIBarButtonItem *likeButton;
@property(nonatomic,assign) BOOL likeButtonIsSelected;
@property(nonatomic,copy) NSString *strContent;
@end

@implementation QuestionViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
    if (self) {
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_question"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_question_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 底部导航item
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"问题" image:nil tag:0];
        
        tabBarItem.image = deselectedImage;
        tabBarItem.selectedImage = selectedImage;
        self.tabBarItem = tabBarItem;
       
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLikeButton];
    
    [self questionScorll];
    FIObserverNetWork *observerNetWork = [[FIObserverNetWork alloc]init];
    NSLog(@"%ld",[observerNetWork isCurrentReachabilityStatus]);
    if ([observerNetWork isCurrentReachabilityStatus]) {
    [self setContent];
    }
    
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
#pragma mark - 加入button
- (void)addLikeButton{
    self.likeButtonIsSelected = NO;
    [self.navigationItem setTitle:@"问题"];

    self.likeButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home_like"] style:UIBarButtonItemStylePlain target:self action:@selector(saveContent)];
    self.navigationItem.rightBarButtonItem = self.likeButton;
}
#pragma mark - 点击喜欢button保存方法
- (void)saveContent{
   
    if (self.likeButtonIsSelected) {
        self.likeButton.image =[UIImage imageNamed:@"home_like"];
        self.likeButtonIsSelected = NO;
        [self removeQuestion];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"取消喜欢啦" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *enterAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:enterAction];
        [self presentViewController:alert animated:YES completion:nil];

    }else{
        if(![self saveQuestion]) return;
    self.likeButton.image =[UIImage imageNamed:@"home_like_hl"];
        self.likeButtonIsSelected = YES;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已经添加到喜欢列表" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *enterAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:enterAction];
        [self presentViewController:alert animated:YES completion:nil];
           }
}
#pragma mark - 保存
- (BOOL)saveQuestion{
    if (self.strContent) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *name =  [userDefault objectForKey:@"userName"];
        
         NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject ;
        NSData *strData =[self.strContent dataUsingEncoding:NSUTF8StringEncoding];
       
        if (name != nil) {//名字不为空，创建名字的文件夹中caches
            NSString *doucumentFilePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/Question",name]];
            
            [fm createDirectoryAtPath:doucumentFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            [strData writeToFile:[doucumentFilePath stringByAppendingPathComponent:self.questionTitleLabel.text] atomically:YES];
            NSLog(@"%@",doucumentFilePath);
            
            
        }else{
            NSString *doucumentFilePath = [filePath stringByAppendingPathComponent:@"User/Question"];
            NSLog(@"^^^^^^^^^^^^^^%@",doucumentFilePath);
            [fm createDirectoryAtPath:doucumentFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            [strData writeToFile:[doucumentFilePath stringByAppendingPathComponent:self.questionTitleLabel.text] atomically:YES];
            NSLog(@"%@",[filePath stringByAppendingPathComponent:self.questionTitleLabel.text]  );
        }
        return 1;
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"等等网络加载完再确定收藏嘛" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *enterAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:enterAction];
        [self presentViewController:alert animated:YES completion:nil];
        return 0;
    }
    
    
}
- (void)removeQuestion{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *name =  [userDefault objectForKey:@"userName"];
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject ;
    
    
    if (name != nil) {
        NSString *doucumentFilePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/Question",name]];
        
        [fm removeItemAtPath:[doucumentFilePath stringByAppendingPathComponent:self.questionTitleLabel.text] error:nil];
  
        
        
    }else{
        NSString *doucumentFilePath = [filePath stringByAppendingPathComponent:@"User/Question"];
       
        [fm removeItemAtPath:[doucumentFilePath stringByAppendingPathComponent:self.questionTitleLabel.text] error:nil];

    }

}
//*questionTitleLabel; //问题
//*questionContentLabel;//问题内容
//*respondContentLabel; //回答
- (void)setContent{
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center = self.view.center;
    [self.view addSubview:activityView];
    [activityView startAnimating];
    FIObserverNetWork *observerNetWork = [[FIObserverNetWork alloc]init];
    NSLog(@"%ld",[observerNetWork isCurrentReachabilityStatus]);
    if ([observerNetWork isCurrentReachabilityStatus]) {
        JSONQuestion *jsonQuestion = [JSONQuestion new];
        [jsonQuestion downLoadQuestion];
        jsonQuestion.question_block = ^(FIQuestionContent *FIcontent){
            NSString *strAnswer =  [FIcontent.strAnswerTitle stringByAppendingString:FIcontent.strAnswerContent];
            strAnswer = [strAnswer stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];
            [activityView stopAnimating];
            self.questionTitleLabel.text = FIcontent.strQuestionTitle;
            self.questionContentLabel.text = FIcontent.strQuestionContent;
            self.respondContentLabel.text = strAnswer;
            
            self.strContent = [NSString stringWithFormat:@"%@space%@space%@",FIcontent.strQuestionTitle,FIcontent.strQuestionContent,strAnswer];
            
            NSLog(@"%@",self.strContent);
        };

    }
  
}















/**
 *  scrollView
 */
- (void)questionScorll{
    self.scrollView = [[UIScrollView alloc]init];
    self.questionImageView = [[UIImageView alloc]init];
    self.questionTitleLabel = [[UILabel alloc]init];
    self.questionContentLabel = [[UILabel alloc]init];
    self.respondContentLabel = [[UILabel alloc]init];
    self.lineImageView = [[UIImageView alloc]init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.questionImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.questionTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.questionContentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.respondContentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.questionImageView];
    [self.scrollView addSubview:self.questionTitleLabel];
    [self.scrollView addSubview:self.questionContentLabel];
    [self.scrollView addSubview:self.respondContentLabel];
    [self.scrollView addSubview:self.lineImageView];
    
      [self.view layoutIfNeeded];
    /**
     *  init
     */
    self.questionImageView.image = [UIImage imageNamed:@"compose_guide_check_box_check"];
    self.lineImageView.backgroundColor = [UIColor blackColor];
    self.questionTitleLabel.numberOfLines = 0;
    self.questionContentLabel.numberOfLines = 0;
    self.respondContentLabel.numberOfLines = 0;
    
    

    self.respondContentLabel.font = [UIFont systemFontOfSize:18];
   
    [self.view addSubview:self.scrollView];
    /**
     *  viewDictionary and metricsDictionary
     */
    NSDictionary *viewDic = @{
                              @"scrollView":self.scrollView,
                              @"questionTitleLabel":self.questionTitleLabel,
                              @"questionContentLabel":self.questionContentLabel,
                              @"respondContentLabel":self.respondContentLabel,
                              @"lineImageView":self.lineImageView,
                              @"questionImageView":self.questionImageView
                              };
    NSNumber *viewWidth =[NSNumber numberWithFloat:self.view.frame.size.width];
    NSNumber *labelWidth = [NSNumber numberWithFloat:self.view.frame.size.width-20];
    NSNumber *fiftypercentViewHeight = [NSNumber numberWithFloat:self.view.frame.size.height*0.5];
    NSDictionary *metrics =@{
                             @"viewWidth":viewWidth,
                             @"labelWidth":labelWidth,
                             @"titleWidth":@100,
                             @"fiftypercentViewHeight":fiftypercentViewHeight,
                             };
    
    /**
     *  scrollView constraints
     */
    NSString *scrollViewVFL = @"|-0-[scrollView]-0-|";
    NSString *scrollViewHVFL = @"V:|-0-[scrollView]-0-|";
    
    NSArray *csscrollView =[NSLayoutConstraint constraintsWithVisualFormat:scrollViewVFL
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewDic];
    NSArray *csscrollViewV = [NSLayoutConstraint constraintsWithVisualFormat:scrollViewHVFL
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDic];
    [self.view addConstraints:csscrollView];
    [self.view addConstraints:csscrollViewV];
    
    /**
     *  respondContentLabel constraints
     */
    NSString *respondContentLabelVFL = @"|-10-[respondContentLabel(labelWidth)]-10-|";
    NSString *respondContentLabelHVFL = @"V:|-fiftypercentViewHeight-[respondContentLabel]-0-|";
    NSArray *csrespondContentLabel = [NSLayoutConstraint constraintsWithVisualFormat:respondContentLabelVFL
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:viewDic];
    NSArray *csrespondContentLabelV = [NSLayoutConstraint constraintsWithVisualFormat:respondContentLabelHVFL
                                                                              options:0
                                                                              metrics:metrics
                                                                                views:viewDic];
    [self.scrollView addConstraints:csrespondContentLabel];
    [self.scrollView addConstraints:csrespondContentLabelV];
  
    NSString *lineImageViewVFL = @"|-10-[lineImageView(labelWidth)]-10-|";
    NSString *lineImageViewHVFL = @"V:[lineImageView(3)]-20-[respondContentLabel]";
    
    NSArray *cslineImageView = [NSLayoutConstraint constraintsWithVisualFormat:lineImageViewVFL
                                                                       options:0
                                                                       metrics:metrics
                                                                         views:viewDic];
    NSArray *cslineImageViewV = [NSLayoutConstraint constraintsWithVisualFormat:lineImageViewHVFL
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:viewDic];
    [self.scrollView addConstraints:cslineImageView];
    [self.scrollView addConstraints:cslineImageViewV];
    /**
     *  questionImageView constraints
     */
    NSString *questionImageViewVFL = @"|-0-[questionImageView(64)]";
    NSString *questionImageViewHVFL = @"V:|-10-[questionImageView(64)]";
    NSArray *csquestionImageView = [NSLayoutConstraint constraintsWithVisualFormat:questionImageViewVFL options:0 metrics:metrics views:viewDic];
    NSArray *csquestionImageViewV = [NSLayoutConstraint constraintsWithVisualFormat:questionImageViewHVFL options:0 metrics:metrics views:viewDic];
    [self.scrollView addConstraints:csquestionImageView];
    [self.scrollView addConstraints:csquestionImageViewV];
    
    /**
     *  questionTitleLabel constraints
     */
    NSString *questionTitleLabelVFL = @"[questionImageView]-0-[questionTitleLabel]-15-|";
    NSString *questionTitleLabelHVFL = @"V:|-10-[questionTitleLabel]-10-[questionContentLabel]";
    NSArray *csquestionTitleLabel = [NSLayoutConstraint constraintsWithVisualFormat:questionTitleLabelVFL options:0 metrics:metrics views:viewDic];
 
    NSArray *csquestionTitleLabelV = [NSLayoutConstraint constraintsWithVisualFormat:questionTitleLabelHVFL options:0 metrics:metrics views:viewDic];
    [self.scrollView addConstraints:csquestionTitleLabel];
    [self.scrollView addConstraints:csquestionTitleLabelV];
    
    /**
     *  questionContentLabel constraints
     */
    NSString *questionContentLabelVFL = @"|-10-[questionContentLabel(labelWidth)]";
    NSString *questionContentLabelHVFL = @"V:[questionImageView]-30-[questionContentLabel]-5-[lineImageView]";
    NSArray *csquestionContentLabel = [NSLayoutConstraint constraintsWithVisualFormat:questionContentLabelVFL
                                                                              options:0
                                                                              metrics:metrics
                                                                                views:viewDic];
    NSArray *csquestionContentLabelV = [NSLayoutConstraint constraintsWithVisualFormat:questionContentLabelHVFL
                                                                               options:0
                                                                               metrics:metrics
                                                                                 views:viewDic];
    [self.scrollView addConstraints:csquestionContentLabel];
    [self.scrollView addConstraints:csquestionContentLabelV];
    NSLog(@"%@",NSStringFromCGRect(self.questionContentLabel.frame));
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
