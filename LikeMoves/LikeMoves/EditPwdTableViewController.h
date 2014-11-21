//
//  EditPwdTableViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-20.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "User.h"
#import "LMUserActBL.h"
#import "LMUserBLDelegate.h"
@interface EditPwdTableViewController : UITableViewController<LMUserBLDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (weak, nonatomic) IBOutlet UITextField *oldPwd;
@property (weak, nonatomic) IBOutlet UITextField *rePwd;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPwd;
- (IBAction)comfirmTo:(id)sender;

@property LMUserActBL* bl;

@end
