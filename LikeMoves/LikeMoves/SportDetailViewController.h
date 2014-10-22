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
#import "LMSportBL.h"
#import "User.h"
@interface SportDetailViewController : UIViewController<PNChartDelegate,LMSportBLDelegate>
@property (nonatomic) PNBarChart * barChart;
@property (weak, nonatomic) IBOutlet UILabel *monthMoveDays;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;
@property (nonatomic,strong) LMSportBL* bl;
- (IBAction)backTo:(id)sender;
- (IBAction)toMarket:(id)sender;

@end
