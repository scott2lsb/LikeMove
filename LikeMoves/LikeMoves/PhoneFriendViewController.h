//
//  PhoneFriendViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-9.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMContactBLDelegate.h"
#import "LMContactBL.h"
@interface PhoneFriendViewController : UIViewController<LMContactBLDelegate>
@property (strong,nonatomic) LMContactBL* bl;
@property (weak, nonatomic) IBOutlet UITextField *phoneInput;
- (IBAction)back:(id)sender;
- (IBAction)searchFriend:(id)sender;

@end
