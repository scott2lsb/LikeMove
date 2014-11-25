//
//  AcceptFriendTableViewCell.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-25.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "AcceptFriendTableViewCell.h"

@implementation AcceptFriendTableViewCell

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
		[self.contentView addSubview:self.phone];
        
       //接收按钮
        self.acceptBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.acceptBtn.frame=CGRectMake(208, 7, 46, 30);
        [self.acceptBtn setTitle:@"接受" forState:UIControlStateNormal];
        NSString *icon = [NSString stringWithFormat:@"smssdk.bundle/button2.png"];
        [self.acceptBtn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [self.acceptBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [self.acceptBtn addTarget:self action:@selector(AcceptBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.acceptBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [self.contentView addSubview:self.acceptBtn];
        //拒绝按钮
        self.rejectBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.rejectBtn.frame=CGRectMake(258, 7, 46, 30);
        [self.rejectBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        NSString *icon1 = [NSString stringWithFormat:@"smssdk.bundle/button2.png"];
        [self.rejectBtn setBackgroundImage:[UIImage imageNamed:icon1] forState:UIControlStateNormal];
        [self.rejectBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.rejectBtn addTarget:self action:@selector(RejectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.rejectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [self.contentView addSubview:self.rejectBtn];
    }
    return self;
}

- (void)AcceptBtnClick {
    if ([self.delegate respondsToSelector:@selector(AcceptFriendCellBtnClick:)]) {
        [self.delegate AcceptFriendCellBtnClick:self];
    }
}
- (void)RejectBtnClick {
    if ([self.delegate respondsToSelector:@selector(RejectFriendCellBtnClick:)]) {
        [self.delegate RejectFriendCellBtnClick:self];
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
