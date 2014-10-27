//
//  ProductCommentTableViewCell.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-27.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ProductCommentTableViewCell.h"

@implementation ProductCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		UIColor * bgColor = [UIColor whiteColor];
		// 设置该使用淡绿色背景
		self.contentView.backgroundColor = bgColor;
		      
		// 创建一个用于显示昵称的标签
		self.nameField = [[UILabel alloc]
                          initWithFrame:CGRectMake(5 , 0 , 160 , 20)];
		// 设置左对齐
		self.nameField.textAlignment = NSTextAlignmentLeft;
		// 设置字体
		self.nameField.font = [UIFont systemFontOfSize:12];
		// 设置文字颜色
		self.nameField.textColor = [UIColor blackColor];
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.nameField];
		

		
		// 创建一个用于显示时间的标签
		self.timeField = [[UILabel alloc]
                           initWithFrame:CGRectMake(160 , 0 , 150 , 20)];
		// 设置左对齐
		self.timeField.textAlignment = NSTextAlignmentRight;
		// 设置字体
		self.timeField.font = [UIFont systemFontOfSize:12];
		// 设置文字颜色
		self.timeField.textColor = [UIColor blackColor];
		// 将self.nameField添加到当前单元格中		
		[self.contentView addSubview:self.timeField];
        
        // 创建一个用于显示评论的标签
		self.content = [[UILabel alloc]
                          initWithFrame:CGRectMake(5 , 20 , 320 , 40)];
		// 设置左对齐
		self.content.textAlignment = NSTextAlignmentLeft;
		// 设置字体
		self.content.font = [UIFont boldSystemFontOfSize:18];
		// 设置文字颜色
		self.content.textColor = [UIColor blackColor];
        
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.content];

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
