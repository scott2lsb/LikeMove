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

@interface RadarFriendViewController : UIViewController{
    RTSpinKitView *spinner;}
- (IBAction)backTo:(id)sender;

- (IBAction)radarSearch:(id)sender;

@end
