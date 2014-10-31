//
//  AddReceiverViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-30.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "AddReceiverViewController.h"

@interface AddReceiverViewController ()

@end

@implementation AddReceiverViewController
NSArray* books;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //收货地址 ”区“的选择
    // 创建、并初始化NSArray对象。
	books = [NSArray arrayWithObjects:@"兰山区",@"河东区", @"罗庄区" ,nil];
    //, @"郯城",@"苍山",@"莒南",@"临沭", @"费县",@"蒙阴","平邑",@"沂南",@"沂水"
	// 为UIPickerView控件设置dataSource和delegate
	self.districtPickView.dataSource = self;
	self.districtPickView.delegate = self;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Picker View  Delegate

// UIPickerViewDataSource中定义的方法，该方法返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
	// 返回1表明该控件只包含1列
	return 1;
}
// UIPickerViewDataSource中定义的方法，该方法返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
	// 由于该控件只包含一列，因此无需理会列序号参数component
	// 该方法返回books.count，表明books包含多少个元素，该控件就包含多少行
	return books.count;
}
// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列、指定列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	// 由于该控件只包含一列，因此无需理会列序号参数component
	// 该方法根据row参数来返回books中的元素，row参数代表列表项的编号，
	// 因此该方法表示第几个列表项，就使用books中的第几个元素
	return [books objectAtIndex:row];
}
// 当用户选中UIPickerViewDataSource中指定列、指定列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
	// 使用一个UIAlertView来显示用户选中的列表项
	UIAlertView* alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:[NSString stringWithFormat:@"你选中的地区是：%@"
                                   , [books objectAtIndex:row]]
                          delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
	[alert show];
}
@end
