//
//  AlipaySuccessViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-20.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlipaySuccessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *orderNO;
@property (weak, nonatomic) IBOutlet UILabel *realPrice;
- (IBAction)payComplete:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *failOrderNO;
- (IBAction)payFailComplete:(id)sender;

@end
