//
//  wendu_yuan2.m
//  2014621
//
//  Created by 孔凡群 on 14-6-30.
//  Copyright (c) 2014年 孔凡群. All rights reserved.
//

#import "wendu_yuan2.h"
#import "yuan2_sc.h"
#import "yuan2_zj.h"
@implementation wendu_yuan2
//托空间初始化
-(void)awakeFromNib{
    [self setchushihua];
}

//代码创建初始化
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setchushihua];
    return  self;
}
-(id)init{
    self=[super init];
    [self setchushihua];
    return self;
}
-(void)setchushihua{
    _kd = 30;
    _sc = [[yuan2_sc alloc]init];
    _sc.backgroundColor = [UIColor clearColor];
    _zj = [[yuan2_zj alloc]init];
    _zj.backgroundColor = [UIColor clearColor];
//    _led_jishu = [[led_jishu alloc ]init];
//    _led_jishu.backgroundColor = [UIColor clearColor];
    [self insertSubview:_zj atIndex:1];
    [self insertSubview:_sc atIndex:2];
}


//重绘方法
-(void)drawRect:(CGRect)rect{
    
    [self draw_scdcdt:rect];
//    [self draw_jishu:rect];
    
}

//添加计数器
-(void)draw_jishu:(CGRect)rect{
    if(rect.size.width>rect.size.height){
        _led_jishu.frame = CGRectMake(0, 0, 2*rect.size.height/3, rect.size.height/3);
    }else {
        _led_jishu.frame = CGRectMake(0, 0, 2*rect.size.width/3, rect.size.width/3);
    }
    
    _led_jishu.layer.position = CGPointMake(rect.size.width/2, rect.size.height/2);
    _led_jishu.z = _z*50;
    [self insertSubview:_led_jishu atIndex:0];
    
}

//添加上层,中间层，底层
-(void)draw_scdcdt:(CGRect)rect{
    _sc.frame = rect;
    _zj.frame = rect;
    //宽度，值，宽度
    _sc.sc_kd = _kd+5;
    _zj.z = _z;
    _zj.zj_kd = _kd;
}



-(void)setKd:(float)kd{
    _kd = kd>20?20:kd;
    [self setNeedsDisplay];
}
-(void)setZ:(float)z{
    _z = z;
    [self setNeedsDisplay];
}
@end
