//
//  ResetPwdViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-7.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMUserBLDelegate.h"
#import "LMUserActBL.h"
@interface ResetPwdViewController : UIViewController<LMUserBLDelegate>
@property (strong,nonatomic) LMUserActBL* bl;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UITextField *resetPwd;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPwd;
@property (nonatomic,copy)   NSString* phoneNum;
- (IBAction)back:(id)sender;

- (IBAction)resetPwd:(id)sender;
@end
