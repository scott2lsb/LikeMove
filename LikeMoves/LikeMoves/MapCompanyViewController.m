//
//  MapCompanyViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "MapCompanyViewController.h"

@interface MapCompanyViewController ()

@end

@implementation MapCompanyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置地图的显示风格，此处设置使用标准地图
	self.comAdrMap.mapType = MKMapTypeStandard;
	// 设置地图可缩放
	self.comAdrMap.zoomEnabled = YES;
	// 设置地图可滚动
	self.comAdrMap.scrollEnabled = YES;
	// 设置地图可旋转
	self.comAdrMap.rotateEnabled = YES;
	// 设置显示用户当前位置
	self.comAdrMap.showsUserLocation = YES;
	// 为MKMapView设置delegate
//	self.comAdrMap.delegate = self;
	// 调用自己实现的方法设置地图的显示位置和显示区域
	[self locateToLatitude:35.033651 longitude:118.36215];
	[self locateToLatitude2:35.047021 longitude:118.361571];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CustomMethod
- (void)locateToLatitude:(CGFloat)latitude longitude:(CGFloat)longitude
{
	// 设置地图中心的经、纬度
	CLLocationCoordinate2D center = {latitude , longitude};
	// 也可以使用如下方式设置经、纬度
	//	center.latitude = latitude;
	//	center.longitude = longitude;
	// 设置地图显示的范围，
	MKCoordinateSpan span;
	// 地图显示范围越小，细节越清楚
	span.latitudeDelta = 0.1;
	span.longitudeDelta = 0.1;
	// 创建MKCoordinateRegion对象，该对象代表了地图的显示中心和显示范围。
	MKCoordinateRegion region = {center,span};
	// 设置当前地图的显示中心和显示范围
	[self.comAdrMap setRegion:region animated:YES];
    // 创建MKPointAnnotation对象——代表一个锚点
	MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
	annotation.title = @"采果果旗舰店";
	annotation.subtitle = @"临沂市兰山区博雅新苑商铺1号";
	CLLocationCoordinate2D coordinate = {latitude , longitude};
	annotation.coordinate = coordinate;
	// 添加锚点
	[self.comAdrMap addAnnotation:annotation];

}

- (void)locateToLatitude2:(CGFloat)latitude longitude:(CGFloat)longitude
{
//	// 设置地图中心的经、纬度
//	CLLocationCoordinate2D center = {latitude , longitude};
//	// 也可以使用如下方式设置经、纬度
//	//	center.latitude = latitude;
//	//	center.longitude = longitude;
//	// 设置地图显示的范围，
//	MKCoordinateSpan span;
//	// 地图显示范围越小，细节越清楚
//	span.latitudeDelta = 0.01;
//	span.longitudeDelta = 0.01;
//	// 创建MKCoordinateRegion对象，该对象代表了地图的显示中心和显示范围。
//	MKCoordinateRegion region = {center,span};
//	// 设置当前地图的显示中心和显示范围
//	[self.comAdrMap setRegion:region animated:YES];
    // 创建MKPointAnnotation对象——代表一个锚点
	MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
	annotation.title = @"采果果分店";
	annotation.subtitle = @"临沂市兰山区香榭丽舍西门商铺3号";
	CLLocationCoordinate2D coordinate = {latitude , longitude};
	annotation.coordinate = coordinate;
	// 添加锚点
	[self.comAdrMap addAnnotation:annotation];
    
}

@end
