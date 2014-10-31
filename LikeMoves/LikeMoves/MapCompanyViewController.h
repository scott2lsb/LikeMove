//
//  MapCompanyViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapCompanyViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *comAdrMap;

@end
