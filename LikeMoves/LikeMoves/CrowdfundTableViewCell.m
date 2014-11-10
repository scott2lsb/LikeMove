//
//  CrowdfundTableViewCell.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-30.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "CrowdfundTableViewCell.h"

@implementation CrowdfundTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 创建一个用于显示昵称的标签
		self.nickname = [[UILabel alloc]
                        initWithFrame:CGRectMake(10 , 10 , 150 , 40)];
		// 设置左对齐
		self.nickname.textAlignment = NSTextAlignmentLeft;
		// 设置字体
		self.nickname.font = [UIFont boldSystemFontOfSize:18];
		// 设置文字颜色
		self.nickname.textColor = [UIColor orangeColor];
        
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.nickname];
        
        // 创建一个用于显示金币数量的标签
		self.coinNum = [[UILabel alloc]
                         initWithFrame:CGRectMake(200, 10 , 80 , 40)];
		// 设置左对齐
		self.coinNum.textAlignment = NSTextAlignmentLeft;
		// 设置字体
		self.coinNum.font = [UIFont boldSystemFontOfSize:15];
		// 设置文字颜色
		self.coinNum.textColor = [UIColor blackColor];
        
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.coinNum];
        
        
        // 创建一个用于显示昵称的标签
		self.coinImg = [[UIImageView alloc]
                         initWithFrame:CGRectMake(255, 0, 60, 60)];
        [_coinImg setContentMode:UIViewContentModeScaleToFill];
		_coinImg.image=[UIImage imageNamed:@"coins@100.png"];
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.coinImg];


    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
