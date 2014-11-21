//
//  UserCenterViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-19.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYCustomMultiSelectPickerView.h"
#import "ALPickerView.h"
#import "LMComBoxView.h"
#import "LMUserActBL.h"
@interface UserCenterViewController : UITableViewController <CYCustomMultiSelectPickerViewDelegate,LMUserBLDelegate,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) LMUserActBL* bl;

- (IBAction)editCancel:(id)sender;

- (IBAction)back:(id)sender;
@end
