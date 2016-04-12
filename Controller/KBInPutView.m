//
//  InPutView.m
//  text
//
//  Created by Fidetro on 16/4/7.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import "KBInPutView.h"
@interface KBInPutView ()<UITextFieldDelegate>

/** 套在评论按钮的firstResponder **/
@property(nonatomic,strong)UITextField *buttonField;
@end
@implementation KBInPutView
- (CGFloat)height{
    return self.frame.size.height;
}
- (CGFloat)width{
    return self.frame.size.width;
}

- (instancetype)initCommentWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
       
          self.commentTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, self.width * 0.7, self.height * 0.6)];
        self.commentButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 70, self.height - 65, 60, 60)];

       
    }
    return self;
}





- (void)setCommentTextField:(UITextField *)commentTextField{
    _commentTextField = commentTextField;
    _commentTextField.backgroundColor = [UIColor whiteColor];
    _commentTextField.delegate = self;
    _commentTextField.alpha = 0;
    [self addSubview:_commentTextField];
}

- (void)setCommentButton:(UIButton *)commentButton{
    _commentButton = commentButton;
    [_commentButton setBackgroundImage:[UIImage imageNamed:@"icon_information_normal"] forState:UIControlStateNormal];
    [_commentButton addTarget:self action:@selector(showUp) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_commentButton];
}

- (void)showUp{
 
      [self.commentTextField becomeFirstResponder];
    [self.delegate callBackKeyboard];
}
@end
