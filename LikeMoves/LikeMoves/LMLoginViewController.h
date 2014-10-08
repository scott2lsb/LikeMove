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
#import "CYCustomMultiSelectPickerView.h"
@interface LMLoginViewController : UIViewController<LMUserBLDelegate,CYCustomMultiSelectPickerViewDelegate,UIAlertViewDelegate>
/**
 *  用户信息编辑界面锻炼地点多选器
 */
{
    NSArray *entries;
    NSArray *entriesSelected;
    NSMutableDictionary *selectionStates;
    
    
    CYCustomMultiSelectPickerView *multiPickerView;
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *pickTrainPlace;
@property (weak, nonatomic) IBOutlet UILabel *shouTrainPlace;
- (IBAction)closeRegKeyboard:(id)sender;


@property (nonatomic,strong) LMUserActBL* bl;
@property (nonatomic,copy)   NSString* phoneNum;
@end
