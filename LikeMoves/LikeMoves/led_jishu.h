//
//  led_jishu.h
//  2014621
//
//  Created by 孔凡群 on 14-7-2.
//  Copyright (c) 2014年 孔凡群. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface led_jishu : UIView
@property(nonatomic)CAGradientLayer * gradientlayer;
@property(nonatomic)CAGradientLayer * gradientlayer2;
@property(nonatomic)CAShapeLayer *shapelayer;
@property(nonatomic)NSArray * arrayColor;
@property(nonatomic)NSArray * arrayColor2;
@property(nonatomic)UILabel * label,*label2;
@property(nonatomic)UIFont * font1,*font2;
@property(nonatomic)float z;
@end
