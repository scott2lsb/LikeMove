//
//  LMLoginViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-15.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMUserActBL.h"
#import "LMUserBLDelegate.h"
@interface LMLoginViewController : UIViewController<LMUserBLDelegate>
@property (nonatomic,strong) LMUserActBL* bl;

@end
