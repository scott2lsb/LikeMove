//
//  ShopCartConfirmTableViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-10.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ShopCartConfirmTableViewController.h"

@interface ShopCartConfirmTableViewController ()

@end

@implementation ShopCartConfirmTableViewController

NSString* shipingMethod=@"2";
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
    _receiverID=@"0";
    _bl=[[LMShopBL alloc] init];
    _bl.delegate=self;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]   initWithTarget:self action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tap];
    
    
    _coinNum.delegate=self;
    self.tableView.delegate=self;
    _total.text=[NSString stringWithFormat:@"￥%0.2f",[[_detail objectForKey:@"totalPrice"] floatValue]];
    _maxDeduction.text=[NSString stringWithFormat:@"￥%0.2f",[[_detail objectForKey:@"maxDeduction"] floatValue]];
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults                                                            standardUserDefaults] objectForKey:mUserInfo]];
    _sumCoins.text=[NSString stringWithFormat:@"%@个",user.coins];
    _coinNum.clearsOnInsertion=YES;
    _realPrice.text=[NSString stringWithFormat:@"￥%0.2f",[[_detail objectForKey:@"totalPrice"] floatValue]];
}
-(void)dismissKeyboard {
//    [_coinNum resignFirstResponder];
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    DLog(@"%d,%d,%d",indexPath.row,indexPath.section,[[_detail objectForKey:@"totalPrice"] intValue]);
    if(indexPath.row==1&indexPath.section==0&[[_detail objectForKey:@"totalPrice"] intValue]>59){
        shipingMethod=@"1";
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ReceiverPage"];
        
        [self.navigationController pushViewController:tabVC animated:YES];
    }else{
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    }
    
    
}

#pragma mark - TextField Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //NSUserDefaults刷新金币数量，使用NSUserDefaults中的数据
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults                                                            standardUserDefaults] objectForKey:mUserInfo]];
    if([textField.text intValue]>[user.coins intValue]&[textField.text intValue]>[[_detail objectForKey:@""] floatValue]*100 ){
        
        textField.text=@"0";
        
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"金币数量不足" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }else{
        _deduction.text=[NSString stringWithFormat:@"￥%0.2f",[textField.text floatValue]/100];
        _realPrice.text=[NSString stringWithFormat:@"￥%0.2f",([[_detail objectForKey:@"totalPrice"] floatValue]-[textField.text floatValue]/100 )];
    }

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

- (IBAction)confirmTo:(id)sender {
    NSString* ids=(NSString*)[_detail objectForKey:@"shopping_ids"];
    NSString* coinNum=_coinNum.text;

    [_bl addOrderWithShopIds:ids receiverID:_receiverID coins:coinNum comment:nil shipingMethod:shipingMethod phoneConfirm:nil userID:nil];
}
-(void)addCartToOrderSuccess{
    //TODO: 跳转支付页面
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"123" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}
@end
