//
//  InPutView.h
//  text
//
//  Created by Fidetro on 16/4/7.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CommentButtonDelegate <NSObject>
- (void)callBackKeyboard;
@end
@interface KBInPutView : UIView
/** 评论文本框 **/
@property(nonatomic,strong)UITextField *commentTextField;
/** 评论按钮 **/
@property(nonatomic,strong)UIButton *commentButton;

/** 点击评论的代理 **/
@property(nonatomic,weak)id<CommentButtonDelegate> delegate;

/*评论视图*/
- (instancetype)initCommentWithFrame:(CGRect)frame;
@end
