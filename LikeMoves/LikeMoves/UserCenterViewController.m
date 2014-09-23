//
//  UserCenterViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-19.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "UserCenterViewController.h"
#import "User.h"
#import "LMContainsLMComboxScrollView.h"
#define kDropDownListTag 1000
@interface UserCenterViewController ()
/**
 *  用户信息编辑界面锻炼地点多选器
 */
{
    NSArray *entries;
    NSArray *entriesSelected;
    NSMutableDictionary *selectionStates;

    
    CYCustomMultiSelectPickerView *multiPickerView;


    }
/**
 *  信息编辑界面
 */
@property (weak, nonatomic) IBOutlet UIButton *trainBtn;
@property (weak, nonatomic) IBOutlet UILabel *showLbl;
//选择 区 的pickerview
@property (weak, nonatomic) IBOutlet UIPickerView *districtPickerView;
@property (weak, nonatomic) IBOutlet UITextField *editAge;

@property (weak, nonatomic) IBOutlet UITextField *editNickname;

- (IBAction)finishComplete:(id)sender;




/**
 *  个人中心元素
 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *coins;
@property (weak, nonatomic) IBOutlet UILabel *balance;
- (IBAction)logout:(id)sender;
/**
 *  用户信息界面元素
 */
@property (weak, nonatomic) IBOutlet UILabel *sPhone;
@property (weak, nonatomic) IBOutlet UILabel *sBalance;
@property (weak, nonatomic) IBOutlet UILabel *sCoins;
@property (weak, nonatomic) IBOutlet UILabel *sNickname;
@property (weak, nonatomic) IBOutlet UILabel *sSex;
@property (weak, nonatomic) IBOutlet UILabel *sAge;
@property (weak, nonatomic) IBOutlet UILabel *sTrainAdr;
@property (weak, nonatomic) IBOutlet UILabel *sHomeAdr;
@end

@implementation UserCenterViewController
NSArray* books;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //逻辑层注册
    _bl=[LMUserActBL new];
    _bl.delegate=self;
    
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:mUserInfo]];
    /**
     *  个人中心信息
     */
    [_phone setText:user.phone];
    [_nickname setText:user.nickName];
    [_coins setText:user.coins ];
    [_balance setText:user.balance] ;
    
    [_sPhone setText:user.phone];
    [_sBalance setText:user.balance];
    [_sCoins setText:user.coins];
    [_sNickname setText:user.nickName];
    switch ([user.sex intValue]) {
        case 0:
            [_sSex setText:@"未设置"];
            break;
        case 1 :
            [_sSex setText:@"男"];
            break;
        case 2:
            [_sSex setText:@"女"];
            break;
        default:
            break;
    }
    [_sAge setText:user.age];
    [_sTrainAdr setText:user.trainAddress];
    [_sHomeAdr setText:user.homeAddress];
    
    /**
     *用户信息编辑界面的锻炼地点选择框
     */
    //初始化一下数据，分别为 所有源数据，和 已经选中的数据
	entries = [[NSArray alloc] initWithObjects:@"广场", @"小区周边", @"健身房", @"上下班路上", @"公园",@"其他",nil];
    
    entriesSelected = [[NSArray alloc] init];
	selectionStates = [[NSMutableDictionary alloc] init];
    
    // 配置是否选中状态
	for (NSString *key in entries){
        BOOL isSelected = NO;
        for (NSString *keyed in entriesSelected) {
            if ([key isEqualToString:keyed]) {
                isSelected = YES;
            }
        }
        [selectionStates setObject:[NSNumber numberWithBool:isSelected] forKey:key];
    }
    [_trainBtn addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
    //收货地址 ”区“的选择
    // 创建、并初始化NSArray对象。
	books = [NSArray arrayWithObjects:@"兰山区",@"河东区", @"罗庄区" ,nil];
    //, @"郯城",@"苍山",@"莒南",@"临沭", @"费县",@"蒙阴","平邑",@"沂南",@"沂水"
	// 为UIPickerView控件设置dataSource和delegate
	self.districtPickerView.dataSource = self;
	self.districtPickerView.delegate = self;
}

/**
 *  锻炼地点信息多选框
 */
-(void)getData
{
    //点击后删除之前的PickerView
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[CYCustomMultiSelectPickerView class]]) {
            [view removeFromSuperview];
        }
    }
    
    multiPickerView = [[CYCustomMultiSelectPickerView alloc] initWithFrame:CGRectMake(0,66, [UIScreen mainScreen].bounds.size.width, 260+44)];
    
    //  multiPickerView.backgroundColor = [UIColor redColor];
    multiPickerView.entriesArray = entries;
    multiPickerView.entriesSelectedArray = entriesSelected;
    multiPickerView.multiPickerDelegate = self;
    
    [self.view addSubview:multiPickerView];
    
    [multiPickerView pickerShow];
    
}
- (IBAction)logout:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:mUserDefaultsCookie];
    [[NSUserDefaults standardUserDefaults]  removeObjectForKey:mUserInfo];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginPage"];
    [self presentViewController:tabVC animated:YES completion:^(void){
    }];
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)finishComplete:(id)sender {
    [_bl editUserInfo:_editNickname.text sex:_editAge.text age:_editAge.text];
}

#pragma mark - Training_Place_Delegate
//获取到选中的数据
-(void)returnChoosedPickerString:(NSMutableArray *)selectedEntriesArr
{
    NSLog(@"selectedArray=%@",selectedEntriesArr);
    
    NSString *dataStr = [selectedEntriesArr componentsJoinedByString:@","];
    
    _showLbl.text = dataStr;
    // 再次初始化选中的数据
    entriesSelected = [NSArray arrayWithArray:selectedEntriesArr] ;
}


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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editUserInfoSuccess{
    
}
-(void)editUserInfoFail{
    
}
@end
