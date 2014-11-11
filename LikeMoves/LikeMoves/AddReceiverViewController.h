//
//  AddReceiverViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-30.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMShopBL.h"
#import "LMShopBLDelegate.h"
@interface AddReceiverViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,LMShopBLDelegate>{
    NSString* district;
}
@property (weak, nonatomic) IBOutlet UIPickerView *districtPickView;
@property (weak, nonatomic) IBOutlet UITextField *receiverName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *detailAdr;
@property(strong,nonatomic)LMShopBL* bl;
- (IBAction)addReceiver:(id)sender;
@property (strong,nonatomic)NSArray* books;
@end
