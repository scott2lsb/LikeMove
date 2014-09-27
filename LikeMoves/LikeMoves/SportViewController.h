//
//  SportViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-22.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wendu_yuan2.h"
#import "LMSportBLDelegate.h"
#import "LMSportBL.h"
#import "DKCircleButton.h"
@interface SportViewController : UIViewController<LMSportBLDelegate>
@property (weak, nonatomic) IBOutlet UIView *sportCircle;
@property(nonatomic) wendu_yuan2 * wdSport;
@property (weak, nonatomic) IBOutlet UILabel *stepCount;
@property (weak, nonatomic) IBOutlet UIImageView *stepImg;
@property (nonatomic) DKCircleButton *fireBtn;
@property (weak, nonatomic) IBOutlet UIView *circleBtnView;


@property (nonatomic,strong) LMSportBL* bl;
@end
