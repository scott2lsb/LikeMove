//
//  OrderTableViewCell.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-9.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // 创建一个用于显示订单号的标签
		self.orderNO = [[UILabel alloc]
                         initWithFrame:CGRectMake(5 , 5 , 250 , 30)];
		// 设置左对齐
		self.orderNO.textAlignment = NSTextAlignmentLeft;
		// 设置字体
		self.orderNO.font = [UIFont boldSystemFontOfSize:12];
		// 设置文字颜色
		self.orderNO.textColor = [UIColor darkGrayColor];
        
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.orderNO];
        
        // 创建一个用于显示创建时间数量的标签
		self.createTime = [[UILabel alloc]
                        initWithFrame:CGRectMake(5, 25 , 250 , 30)];
		// 设置左对齐
		self.createTime.textAlignment = NSTextAlignmentLeft;
		// 设置字体
		self.createTime.font = [UIFont boldSystemFontOfSize:12];
		// 设置文字颜色
		self.createTime.textColor = [UIColor darkGrayColor];
        
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.createTime];
        
        
        // 创建一个用于显示总价的标签
		self.totalPrice = [[UILabel alloc]
                           initWithFrame:CGRectMake(250, 5 , 60 , 30)];
		// 设置左对齐
		self.totalPrice.textAlignment = NSTextAlignmentLeft;
		// 设置字体
		self.totalPrice.font = [UIFont boldSystemFontOfSize:10];
		// 设置文字颜色
		self.totalPrice.textColor = [UIColor grayColor];
        
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.totalPrice];

        // 创建一个用于显示商品数量的标签
		self.productNO = [[UILabel alloc]
                           initWithFrame:CGRectMake(250, 25 , 60 , 30)];
		// 设置左对齐
		self.productNO.textAlignment = NSTextAlignmentLeft;
		// 设置字体
		self.productNO.font = [UIFont boldSystemFontOfSize:10];
		// 设置文字颜色
		self.productNO.textColor = [UIColor grayColor];
        
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.productNO];

        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
