//
//  DetailHomeViewController.m
//  working
//
//  Created by Fidetro on 16/4/6.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "DetailHomeViewController.h"

@interface DetailHomeViewController ()

@end

@implementation DetailHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction *itemLike = [UIPreviewAction actionWithTitle:@"喜欢" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        DetailHomeViewController *detailVC = (DetailHomeViewController *)previewViewController;
        [self saveInLikeCaches:detailVC.imageView.image];
        NSLog(@"喜欢");
    }];
    UIPreviewAction *itemSavePhoto = [UIPreviewAction actionWithTitle:@"保存图片" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
      DetailHomeViewController *detailVC = (DetailHomeViewController *)previewViewController;
        UIImageWriteToSavedPhotosAlbum(detailVC.imageView.image, self, nil, nil);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        
        [alert show];
       
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
//            [detailVC presentViewController:alert animated:YES completion:nil];
            NSLog(@"保存图片");
     
      
    }];
    UIPreviewAction *itemGoBack = [UIPreviewAction actionWithTitle:@"返回" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"返回");
    }];
 
    return @[itemLike,itemSavePhoto,itemGoBack];
}
//*BOOL    autoLogin
//*NSString  userName
- (void)saveInLikeCaches:(UIImage *)image{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *name =  [userDefault objectForKey:@"userName"];
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString  *dateString = [formatter stringFromDate:date];
        NSData *data =  UIImagePNGRepresentation(image);
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject ;
    if (name != nil) {//名字不为空，创建名字的文件夹中caches
        NSString *doucumentFilePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/Picture",name]];
  
        [fm createDirectoryAtPath:doucumentFilePath withIntermediateDirectories:YES attributes:nil error:nil];
        [data writeToFile:[doucumentFilePath stringByAppendingPathComponent:dateString] atomically:YES];

    }else{
        NSString *doucumentFilePath = [filePath stringByAppendingPathComponent:@"User/Picture"];
        
        [fm createDirectoryAtPath:doucumentFilePath withIntermediateDirectories:YES attributes:nil error:nil];
        [data writeToFile:[doucumentFilePath stringByAppendingPathComponent:dateString] atomically:YES];
      
    }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
