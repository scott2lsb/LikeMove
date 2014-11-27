//
//  RegViewController.h
//  SMS_SDKDemo
//
//  Created by admin on 14-6-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionsViewController.h"
#import "UserActDA.h"
#import "SMS_SDK/SMS_SRReachability.h"
#import "LMUserActDADelegate.h"
@protocol SecondViewControllerDelegate;

@interface RegViewController : UIViewController <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,SecondViewControllerDelegate,UITextFieldDelegate,LMUserActDADelegate>

@property(nonatomic,strong) UITableView* tableView;

@property(nonatomic,strong) UITextField* areaCodeField;

@property(nonatomic,strong) UITextField* telField;

@property(nonatomic,strong) UIWindow* window;

@property(nonatomic,strong) UIButton* next;
@property UserActDA* da;
/**
 *  Yes为regist
 No为reset
 */
@property (nonatomic) BOOL registOrReset;
-(void)nextStep;

@end
