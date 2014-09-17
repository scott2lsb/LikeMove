//
//  LoginViewController.h
//  LikeMove
//
//  Created by 粒橙Leo on 14-9-13.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *loginPwd;
@property (weak, nonatomic) IBOutlet UITextField *loginPhone;
- (IBAction)loginButton:(id)sender;

@end
