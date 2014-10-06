//
//  yuan2_dt.m
//  2014621
//
//  Created by 孔凡群 on 14-7-1.
//  Copyright (c) 2014年 孔凡群. All rights reserved.
//

#import "yuan2_zj.h"

@implementation yuan2_zj

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self chushihua];
    return self;
}
-(void)chushihua{
    _zj_kd = 15;
    _gradientlayer1 = [CAGradientLayer layer];
    _gradientlayer2 = [CAGradientLayer layer];
    
    //渐变范围
    _gradientlayer1.startPoint = CGPointMake(1, 0.08);
    _gradientlayer1.endPoint = CGPointMake(1, 0.3);
    _gradientlayer2.startPoint = CGPointMake(1, 0.3);
    _gradientlayer2.endPoint = CGPointMake(1, 0.6);
    
    _array1 = [NSArray arrayWithObjects:(id)[[UIColor yellowColor] CGColor],(id)[[UIColor greenColor] CGColor], nil];
    _array2 = [NSArray arrayWithObjects:(id)[[UIColor yellowColor] CGColor],(id)[[UIColor redColor] CGColor], nil];
    
    //渐变开始
    _gradientlayer1.colors = _array1;
    _gradientlayer2.colors = _array2;
    
    //将渐变层合并一个层，方便控制
    _layer_d = [CALayer layer];
    [_layer_d insertSublayer:_gradientlayer1 atIndex:0];
    [_layer_d insertSublayer:_gradientlayer2 atIndex:0];
    
    
    //设置蒙板
    _shapelayer = [CAShapeLayer layer];
    
    _shapelayer.fillColor = [[UIColor clearColor]CGColor];
    _shapelayer.strokeColor = [[UIColor redColor] CGColor];
    _shapelayer.backgroundColor = [[UIColor clearColor] CGColor];
    _shapelayer.lineJoin = kCALineJoinRound;
    _shapelayer.lineCap = kCALineCapRound;
    _shapelayer.frame = CGRectMake(0, 0, 0, 0);
    
    
    

}
-(void)setcanshu:(CGRect)rect{
    _bj = (rect.size.height>rect.size.width?rect.size.width/2:rect.size.height/2)-_zj_kd/2;
    _point = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    _rect1 = CGRectMake(rect.size.width/2-_bj-_zj_kd/2, rect.size.height/2-_bj-_zj_kd/2, _bj+_zj_kd/2, 2*_bj+_zj_kd);
    _rect2 = CGRectMake(rect.size.width/2,rect.size.height/2-_bj-_zj_kd/2,_bj+_zj_kd/2, 2*_bj+_zj_kd);
    
    _gradientlayer1.frame = _rect1;
    _gradientlayer2.frame = _rect2;
    
    _layer_d.frame = rect;
    
    if(_shapelayer.frame.origin.x==0||
       _shapelayer.frame.origin.y==0||
       _shapelayer.frame.size.width==0||
       _shapelayer.frame.size.height==0){
        _shapelayer.frame = rect;
        //旋转角度
        _shapelayer.transform = CATransform3DMakeRotation(M_PI/4, 0, 0, 1);
    }

    _shapelayer.lineWidth = _zj_kd;
    _apath = [UIBezierPath bezierPath];
    
    [_apath addArcWithCenter:_point radius:_bj-2 startAngle:M_PI/2 endAngle:M_PI*2 clockwise:YES];

    _shapelayer.path = _apath.CGPath;
    if(_z>_z1){
        _z1 = 0.001+_z>0.999?1:0.001+_z;
    }else {
        _z1 = 0.001+_z<0?0.001:0.001+_z;
    }
    _shapelayer.strokeEnd =_z1;
    
    [_layer_d setMask:_shapelayer];
    [self.layer addSublayer:_layer_d];
    
}


-(void)drawRect:(CGRect)rect{
    [self setcanshu:rect];
    [self draw_yy];

}
//设置阴影
-(void)draw_yy{
    //y阴影
    self.layer.shadowOffset = CGSizeMake(5, 5); //设置阴影的偏移量
    self.layer.shadowRadius = 5.0;  //设置阴影的半径
    self.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
    self.layer.shadowOpacity = 1; //透明度
}
-(void)setZj_kd:(float)zj_kd{
    _zj_kd = zj_kd;
    [self setNeedsDisplay];
}
@end
