//
//  SportDetailViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChartDelegate.h"
#import "PNChart.h"
@interface SportDetailViewController : UIViewController<PNChartDelegate>
@property (nonatomic) PNBarChart * barChart;
- (IBAction)backTo:(id)sender;

@end
