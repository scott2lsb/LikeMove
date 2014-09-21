//
//  CYCustomMultiSelectPickerView.m
//  Courtyard1.1
//
//  Created by Wangmm on 13-1-21.
//
//

#import "CYCustomMultiSelectPickerView.h"
#import "ALPickerView.h"
@interface CYCustomMultiSelectPickerView()<ALPickerViewDelegate>

@property (nonatomic, retain) NSMutableDictionary *selectionStatesDic;
@property (nonatomic, retain) NSMutableArray *selectedEntriesArr;//选中的状态
@property (nonatomic, retain) ALPickerView *pickerView;
@property (nonatomic, retain) UIToolbar *toolBar;
@end

@implementation CYCustomMultiSelectPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.selectionStatesDic = [[NSMutableDictionary alloc] initWithCapacity:16];
        self.selectedEntriesArr = [[NSMutableArray alloc] initWithCapacity:16];
        
        self.entriesArray = [[NSMutableArray alloc] initWithCapacity:16];
        self.entriesSelectedArray = [[NSMutableArray alloc] initWithCapacity:16];
    }
    return self;
}

-(void)dealloc
{
    self.entriesArray = nil;
    self.selectedEntriesArr= nil;
    self.selectionStatesDic = nil;
    self.pickerView = nil;
    self.toolBar = nil;
    

}

- (void)pickerShow
{
 

	for (NSString *key in self.entriesArray){
        BOOL isSelected = NO;
        for (NSString *keyed in self.entriesSelectedArray) {
            if ([key isEqualToString:keyed]) {
                isSelected = YES;
            }
        }
        [self.selectionStatesDic setObject:[NSNumber numberWithBool:isSelected] forKey:key];
    }
    
	// Init picker and add it to view
    if (!self.pickerView) {
        self.pickerView = [[ALPickerView alloc] initWithFrame:CGRectMake(0,260, 320, 260)];
    }
	self.pickerView.delegate = self;
	[self addSubview:self.pickerView];
    
    //创建工具栏
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
	UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmPickView)];
	UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerHide)];
    [items addObject:cancelBtn];
    [items addObject:flexibleSpaceItem];
    [items addObject:confirmBtn];
//    [cancelBtn release];
//    [flexibleSpaceItem release];
//    [confirmBtn release];
    
    if (self.toolBar==nil) {
        self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.pickerView.frame.origin.y - 44, 320, 44)];
    }
    self.toolBar.hidden = NO;
    self.toolBar.barStyle = UIBarStyleDefault;
    self.toolBar.items = items;

    items = nil;
    [self addSubview:self.toolBar];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerView.frame = CGRectMake(0, 44, 320, 260);
        self.toolBar.frame = CGRectMake(0, self.pickerView.frame.origin.y-44, 320, 44);
    }];
  
}
- (void)pickerHide
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
        self.pickerView.frame = CGRectMake(0, 260+44, 320, 260);
        self.toolBar.frame = CGRectMake(0, self.pickerView.frame.origin.y-44, 320, 44);
    }];
}

-(void)confirmPickView
{
    for (NSString *row in [self.selectionStatesDic allKeys]) {
        if ([[self.selectionStatesDic objectForKey:row] boolValue]) {
            [self.selectedEntriesArr addObject:row];
        }
    }
    
//    CYLog(@"tempStr==%@",self.selectedEntriesArr);
    
    if ([self.multiPickerDelegate respondsToSelector:@selector(returnChoosedPickerString:)]) {
        [self.multiPickerDelegate returnChoosedPickerString:self.selectedEntriesArr];
    }
    
    [self pickerHide];
}

#pragma mark -  ALPickerViewDelegate 


// Return the number of elements of your pickerview
-(NSInteger)numberOfRowsForPickerView:(ALPickerView *)pickerView
{
    return [self.entriesArray count];
}
// Return a plain UIString to display on the given row
- (NSString *)pickerView:(ALPickerView *)pickerView textForRow:(NSInteger)row
{
    return [self.entriesArray objectAtIndex:row];
}
// Return a boolean selection state on the given row
- (BOOL)pickerView:(ALPickerView *)pickerView selectionStateForRow:(NSInteger)row
{
    return [[self.selectionStatesDic objectForKey:[self.entriesArray objectAtIndex:row]] boolValue];
}

- (void)pickerView:(ALPickerView *)pickerView didCheckRow:(NSInteger)row {
	// Check whether all rows are checked or only one
	if (row == -1)
		for (id key in [self.selectionStatesDic allKeys])
			[self.selectionStatesDic setObject:[NSNumber numberWithBool:YES] forKey:key];
	else
		[self.selectionStatesDic setObject:[NSNumber numberWithBool:YES] forKey:[self.entriesArray objectAtIndex:row]];
}

- (void)pickerView:(ALPickerView *)pickerView didUncheckRow:(NSInteger)row {
	// Check whether all rows are unchecked or only one
	if (row == -1)
		for (id key in [self.selectionStatesDic allKeys])
			[self.selectionStatesDic setObject:[NSNumber numberWithBool:NO] forKey:key];
	else
		[self.selectionStatesDic setObject:[NSNumber numberWithBool:NO] forKey:[self.entriesArray objectAtIndex:row]];
}
@end
