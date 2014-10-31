//
//  AddReceiverViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-30.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddReceiverViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *districtPickView;

@end
