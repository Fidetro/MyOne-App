//
//  ReadingCell.m
//  working
//
//  Created by ios-28 on 16/3/11.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "FIDReadingCell.h"

#define GetViewWidth(view)    view.frame.size.width
#define GetViewHeight(view)   view.frame.size.height
#define GetViewX(view)        view.frame.origin.x
#define GetViewY(view)        view.frame.origin.y

@interface FIDReadingCell ()<UITableViewDelegate>
@property(nonatomic,strong)UIImageView  *FIImageView;
@property(nonatomic,strong)UILabel *firstLabel;
@property(nonatomic,strong)UILabel *secondLabel;

@end
@implementation FIDReadingCell


- (instancetype)setCellInTableViewAddImageView:(UIImageView *)imageView
                               reuseIdentifier:(NSString *)Identifier{
    if ([super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier]) {
        
        self.FIImageView = imageView;
        [self.contentView addSubview:self.FIImageView];
        
    }
    return self;
}



- (instancetype)setCellInTableViewAddImageView:(UIImageView *)imageView
                              AddImageViewRect:(CGRect)imageViewRect
                               reuseIdentifier:(NSString *)Identifier{
   
   
    if ([super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier]) {
    
        self.FIImageView = imageView;
        self.FIImageView.frame = imageViewRect;
        [self.contentView addSubview:self.FIImageView];
        
    }
    return self;

}



- (instancetype)setCellInTableViewAddImageView:(UIImageView *)imageView
                            AddImageViewRect:(CGRect)imageViewRect
                               AddFirstLabel:(UILabel *)firstLabel
                           AddFirstLabelRect:(CGRect)firstLabelRect
                             reuseIdentifier:(NSString *)Identifier{
    if ([super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier]) {
        
        self.FIImageView = imageView;
        self.FIImageView.frame = imageViewRect;
        self.firstLabel = firstLabel;
        self.firstLabel.frame = firstLabelRect;
        [self.contentView addSubview:self.firstLabel];
        [self.contentView addSubview:self.FIImageView];

    }
    return self;
}


- (instancetype)setCellInTableViewAddImageView:(UIImageView *)imageView
                            AddImageViewRect:(CGRect)imageViewRect
                               AddFirstLabel:(UILabel *)firstLabel
                           AddFirstLabelRect:(CGRect)firstLabelRect
                              AddSecondLabel:(UILabel *)secondLabel
                          AddSecondLabelRect:(CGRect)secondLabelRect
                             reuseIdentifier:(NSString *)Identifier{

    if ([super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier]) {
        
        self.FIImageView = imageView;
        self.FIImageView.frame = imageViewRect;
        self.firstLabel = firstLabel;
        self.firstLabel.frame = firstLabelRect;
        self.secondLabel = secondLabel;
        self.secondLabel.frame = secondLabelRect;
        [self.contentView addSubview:self.firstLabel];
        [self.contentView addSubview:self.secondLabel];
        [self.contentView addSubview:self.FIImageView];
        
    }
    return self;
}

/**
 *  default Mode
 */


- (instancetype)setCellInTableViewDefault1InTableView:(UITableView *)tableView
                                         CellHeight:(CGFloat )CellHeight
                                       AddImageView:(UIImageView *)imageView
                                      AddFirstLabel:(UILabel *)firstLabel
                                      reuseIdentifier:(NSString *)Identifier{
    if ([super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier]) {
        
        self.FIImageView = imageView;
        self.FIImageView.frame = CGRectMake(0, 0, CellHeight, CellHeight);
        self.firstLabel = firstLabel;
        self.firstLabel.frame = CGRectMake(CellHeight, CellHeight * 0.3,GetViewHeight(tableView) - GetViewWidth(self.FIImageView) - GetViewX(self.FIImageView), CellHeight * 0.5);
        [self.contentView addSubview:self.firstLabel];
        [self.contentView addSubview:self.FIImageView];
        
    }
    return self;
}


- (instancetype)setCellInTableViewDefault2InTableView:(UITableView *)tableView
                                         CellHeight:(CGFloat )CellHeight
                                       AddImageView:(UIImageView *)imageView
                                      AddFirstLabel:(UILabel *)firstLabel
                                     AddSecondLabel:(UILabel *)secondLabel
                                     reuseIdentifier:(NSString *)Identifier{
    if ([super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier]) {
        self.FIImageView = imageView;
        self.FIImageView.frame = CGRectMake(0,0, CellHeight, CellHeight);
        self.firstLabel = firstLabel;
        self.firstLabel.frame = CGRectMake(CellHeight,0,GetViewWidth(tableView) - GetViewWidth(self.FIImageView) - GetViewX(self.FIImageView), CellHeight * 0.3);
        self.secondLabel = secondLabel;
        self.secondLabel.frame = CGRectMake(CellHeight,CellHeight * 0.3, GetViewWidth(tableView) - GetViewWidth(self.FIImageView) - GetViewX(self.FIImageView), CellHeight * 0.7);
        
        
        [self.contentView addSubview:self.firstLabel];
        [self.contentView addSubview:self.secondLabel];
        [self.contentView addSubview:self.FIImageView];
    }
    return self;
}
@end
