//
//  InformationTableViewController.m
//  working
//
//  Created by ios-28 on 16/3/17.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "InformationTableViewController.h"
#import "PersonTableViewController.h"
#import "LoginViewController.h"
@interface InformationTableViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong,nonatomic) NSString *headName;

@end

@implementation InformationTableViewController
#pragma mark - 自定义一个navigationcontroller返回person页面
- (void)viewDidLoad {
    [super viewDidLoad];
    


   
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

    self.headName = [userDefault objectForKey:@"userName"];
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@headImage.png",self.headName]];
    BOOL isAutoLogin = [userDefault boolForKey:@"autoLogin"];
    if (isAutoLogin) {
        
      
#warning    判断coredata里面用户有没有图片名字，从里面拿图片名字,不然拿defaultUser
        if (/* DISABLES CODE */ (1)) {
            self.userName.text = self.headName;
            NSData *headIamgeData =   [NSData dataWithContentsOfFile:filePath];
            self.headImageView.image = [UIImage imageWithData:headIamgeData];
        }else{
        self.headImageView.image = [UIImage imageNamed:@"defaultUser"];
        }
        
   

    }
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ( [super initWithCoder:aDecoder]) {

        self.hidesBottomBarWhenPushed = YES;
            UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"首页" style:UIBarButtonItemStylePlain target:self action:@selector(popToRoot)];


               self.navigationItem.leftBarButtonItem = leftButtonItem;
    }
    return self;
}

- (void)popToRoot{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
         NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    switch (cell.tag) {
        case 1:
            [self createActionSheet];
            break;
        case 3:
            
            [userDefault setBool:NO forKey:@"autoLogin"];
            [userDefault setObject:nil forKey:@"userName"];
        
         
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
                   
    }
    
}


#pragma mark - 创建点击图片弹出的AlertController
-(void)createActionSheet {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:@"获取头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开 图片编辑器 用相机的形式打开
        [self chooseHeadImage:(UIImagePickerControllerSourceTypeCamera)];
    }];
    
    UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开 图片编辑器 用相册的形式打开
        [self chooseHeadImage:(UIImagePickerControllerSourceTypePhotoLibrary)];
    }];
    
    
    [alert addAction:cancel];
    [alert addAction:camera];
    [alert addAction:photoLibrary];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)chooseHeadImage:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = type;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //把选中图片取出来
    UIImage *image = info[UIImagePickerControllerEditedImage];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
                               
  NSBlockOperation *op =  [NSBlockOperation blockOperationWithBlock:^{
      NSLog(@"%@",[NSThread currentThread]);
    [self writeImageInFile:image];
      
      [[NSOperationQueue mainQueue]addOperationWithBlock:^{
          self.headImageView.image = image;
          [self dismissViewControllerAnimated:YES completion:nil];
      }];
    }];//开线程保存图片
    [queue addOperation:op];
 
 
}

#pragma mark － 加一个方法，从照片获得，writeinfile  viewwill的时候读取图片是否为空
- (void)writeImageInFile:(UIImage *)image{
    
    
#warning 拿到图片名字存进coreData里面
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@headImage.png",self.headName]];
    NSLog(@"%@",filePath);
    NSData *imageData = [NSData data];
    imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:filePath  atomically:YES];

}

@end
