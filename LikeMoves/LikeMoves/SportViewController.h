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
@interface SportViewController : UIViewController<LMSportBLDelegate>{
    UIButton        *_getBtn;
    UIImageView     *_bagView;      //福袋图层
    NSMutableArray  *_coinTagsArr;  //存放生成的所有金币对应的tag值
    BOOL  isBag;
    CAAnimationGroup* group;
    CABasicAnimation* shake;

}
@property (weak, nonatomic) IBOutlet UIView *sportCircle;
@property(nonatomic) wendu_yuan2 * wdSport;
@property (weak, nonatomic) IBOutlet UILabel *stepCount;

@property (nonatomic) DKCircleButton *fireBtn;


@property (weak, nonatomic) IBOutlet UINavigationItem *sportNaviItem;


@property (nonatomic,strong) LMSportBL* bl;
@end
