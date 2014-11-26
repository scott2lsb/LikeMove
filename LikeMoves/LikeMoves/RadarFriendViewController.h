//
//  RadarFriendViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-4.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTSpinKitView.h"
#import "UIColor+FlatUI.h"
#import "LMContactBL.h"
#import "LMContactBLDelegate.h"
#import "RadarTableViewCell.h"
@interface RadarFriendViewController : UIViewController<LMContactBLDelegate,UITableViewDelegate,UITableViewDataSource,RadarCellDelegate>
{
    RTSpinKitView *spinner;}
@property (strong,nonatomic) LMContactBL* bl;
@property (strong,nonatomic) NSArray* radarFriends;
@property (weak, nonatomic) IBOutlet UITableView *radarTable;
@property (weak, nonatomic) IBOutlet UILabel *radarDetail;

- (IBAction)backTo:(id)sender;

- (IBAction)radarSearch:(id)sender;
- (IBAction)addRadarFriend:(id)sender;

@end
