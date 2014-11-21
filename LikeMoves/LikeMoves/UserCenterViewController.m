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

@property (weak, nonatomic) IBOutlet UITextField *editAge;
@property (weak, nonatomic) IBOutlet UILabel *editPhone;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegment;

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
User* user;
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
    //关闭虚拟键盘
    
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]   initWithTarget:self action:@selector(dismissKeyboard)];
    //    [self.view addGestureRecognizer:tap];
    //去掉table的多余横线
    UIView*view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    self.tableView.delegate=self;
    //逻辑层注册
    _bl=[LMUserActBL new];
    _bl.delegate=self;
    [_bl refreshMyself];
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults                                                            standardUserDefaults] objectForKey:mUserInfo]];
    _editPhone.text=user.phone;
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
    
}


-(void)dismissKeyboard {
    NSArray *subviews = [self.view subviews];
    for (id objInput in subviews) {
        if ([objInput isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objInput;
            if ([objInput isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        }
    }  }

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:mUserInfo]];
    /**
     *  信息编辑页面
     */
    _editPhone.text=user.phone;
    _editNickname.text=user.nickName;
    _editAge.text=user.age;
    _showLbl.text=user.trainAddress;

    switch ([user.sex intValue]) {
        case 0:
            [_sexSegment setSelectedSegmentIndex:0];
            break;
        case 1 :
            [_sexSegment setSelectedSegmentIndex:0];
            break;
        case 2:
            [_sexSegment setSelectedSegmentIndex:1];
            break;
        default:
            break;
    }

    /**
     *  个人中心信息
     */
    [_phone setText:user.phone];
    [_nickname setText:user.nickName];
    [_coins setText:user.coins ];
    [_balance setText:[NSString stringWithFormat:@"￥%0.2f",[user.balance floatValue]]] ;
    
    [_sPhone setText:user.phone];
    [_sBalance setText:[NSString stringWithFormat:@"￥%0.2f",[user.balance floatValue]]];
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
    //    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)finishComplete:(id)sender {
    NSString* nickname=_editNickname.text;
    NSString* age=_editAge.text;
    NSString* sex=[NSString stringWithFormat:@"%d",_sexSegment.selectedSegmentIndex+1 ];
    NSString* trainAddr=_showLbl.text;
    if ([nickname isEqualToString:@""]|[age isEqualToString:@""]|[sex isEqualToString:@""]|[trainAddr isEqualToString:@""]) {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"您的信息不能为空！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else{
    [_bl editUserInfo:nickname sex:sex age:age trainAddr:trainAddr];
    }
}

#pragma mark - Training_Place_Delegate
//获取到选中的数据
-(void)returnChoosedPickerString:(NSMutableArray *)selectedEntriesArr
{
    DLog(@"selectedArray=%@",selectedEntriesArr);
    
    NSString *dataStr = [selectedEntriesArr componentsJoinedByString:@","];
    
    _showLbl.text = dataStr;
    // 再次初始化选中的数据
    entriesSelected = [NSArray arrayWithArray:selectedEntriesArr] ;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editUserInfoSuccess{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"修改成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    [_bl refreshMyself];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editUserInfoFail{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"修改信息失败！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];

}
- (IBAction)editCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_editPhone resignFirstResponder];
    [_editAge resignFirstResponder];
    [_editNickname resignFirstResponder];
}
@end
