//
//  RadarTableViewCell.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-25.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "RadarTableViewCell.h"

@implementation RadarTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nickname = [[UILabel alloc]
                         initWithFrame:CGRectMake(20 , 0 , 196 , 20)];
		// 设置左对齐
		self.nickname.textAlignment = NSTextAlignmentLeft;
		// 设置字体
		self.nickname.font = [UIFont boldSystemFontOfSize:15];
		// 设置文字颜色
		self.nickname.textColor = [UIColor orangeColor];
        
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.nickname];
        
        self.phone = [[UILabel alloc]
                      initWithFrame:CGRectMake(20 , 20 , 196 , 20)];
		// 设置左对齐
		self.phone.textAlignment = NSTextAlignmentLeft;
		// 设置字体
		self.phone.font = [UIFont boldSystemFontOfSize:12];
		// 设置文字颜色
		self.phone.textColor = [UIColor lightGrayColor];
        
		// 将self.nameField添加到当前单元格中
		[self.contentView addSubview:self.phone];
        
        
        //添加好友按钮
//        self.addFriendBtn=[[UIButton alloc] initWithFrame:CGRectMake(270, 5, 42, 33)];
//        self.addFriendBtn.backgroundColor=[UIColor clearColor];
//        [self.addFriendBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//        [self.contentView addSubview:self.addFriendBtn];
//        
        self.addFriendBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        self.addFriendBtn.frame=CGRectMake(254, 7, 46, 30);
        [self.addFriendBtn setTitle:@"添加" forState:UIControlStateNormal];
        NSString *icon = [NSString stringWithFormat:@"smssdk.bundle/button2.png"];
        [self.addFriendBtn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [self.addFriendBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.addFriendBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.addFriendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [self.contentView addSubview:self.addFriendBtn];
    }
    return self;
}
- (void)btnClick {
    if ([self.delegate respondsToSelector:@selector(RadarCellBtnClick:)]) {
        [self.delegate RadarCellBtnClick:self];
    }
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
