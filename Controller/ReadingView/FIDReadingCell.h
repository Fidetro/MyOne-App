//
//  ReadingCell.h
//  working
//
//  Created by ios-28 on 16/3/11.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FIDReadingCell : UITableViewCell


/**
 *  initframe
 */
- (instancetype)setCellInTableViewAddImageView:(UIImageView *)imageView
                               reuseIdentifier:(NSString *)Identifier;

- (instancetype)setCellInTableViewAddImageView:(UIImageView *)imageView
                              AddImageViewRect:(CGRect)imageViewRect
                               reuseIdentifier:(NSString *)Identifier;




- (instancetype)setCellInTableViewAddImageView:(UIImageView *)imageView
                              AddImageViewRect:(CGRect)imageViewRect
                                 AddFirstLabel:(UILabel *)firstLabel
                             AddFirstLabelRect:(CGRect)firstLabelRect
                               reuseIdentifier:(NSString *)Identifier;

- (instancetype)setCellInTableViewAddImageView:(UIImageView *)imageView
                              AddImageViewRect:(CGRect)imageViewRect
                                 AddFirstLabel:(UILabel *)firstLabel
                             AddFirstLabelRect:(CGRect)firstLabelRect
                                AddSecondLabel:(UILabel *)secondLabel
                            AddSecondLabelRect:(CGRect)secondLabelRect
                               reuseIdentifier:(NSString *)Identifier;

/**
 *  default Mode
 */
- (instancetype)setCellInTableViewDefault1InTableView:(UITableView *)tableView
                                           CellHeight:(CGFloat )CellHeight
                                         AddImageView:(UIImageView *)imageView
                                        AddFirstLabel:(UILabel *)firstLabel
                                      reuseIdentifier:(NSString *)Identifier;


- (instancetype)setCellInTableViewDefault2InTableView:(UITableView *)tableView
                                           CellHeight:(CGFloat )CellHeight
                                         AddImageView:(UIImageView *)imageView
                                        AddFirstLabel:(UILabel *)firstLabel
                                       AddSecondLabel:(UILabel *)secondLabel
                                      reuseIdentifier:(NSString *)Identifier;





@end
