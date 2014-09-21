//
//  CYCustomMultiSelectPickerView.h
//  Courtyard1.1
//
//  Created by iZ on 13-1-21.
//
//

#import <UIKit/UIKit.h>
@protocol CYCustomMultiSelectPickerViewDelegate;

@interface CYCustomMultiSelectPickerView : UIView

@property (nonatomic, retain) NSArray *entriesArray;
@property (nonatomic, retain) NSArray *entriesSelectedArray;
@property (nonatomic, assign) id<CYCustomMultiSelectPickerViewDelegate> multiPickerDelegate;

- (void)pickerShow;
@end

@protocol CYCustomMultiSelectPickerViewDelegate <NSObject>
@required
-(void)returnChoosedPickerString:(NSMutableArray *)selectedEntriesArr;
@end