//
//  EditPwdTableViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-20.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "EditPwdTableViewController.h"

@interface EditPwdTableViewController ()

@end

@implementation EditPwdTableViewController
User* user;
- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMUserActBL alloc] init];
    _bl.delegate=self;
    user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults                                                            standardUserDefaults] objectForKey:mUserInfo]];
    _phone.text=user.phone;
    UIView*view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    //收起键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]   initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)dismissKeyboard {
    [_oldPwd resignFirstResponder];
    [_rePwd resignFirstResponder];
    [_comfirmPwd resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)comfirmTo:(id)sender {
    NSString* oldPwd=[self md5:_oldPwd.text];
    if ([_oldPwd.text isEqualToString:@""]) {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"密码不能为空！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else if(![oldPwd isEqualToString:user.password]){
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"旧密码不正确！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];

    }else{
        NSString* rePwd=_rePwd.text;
        NSString* comfirmPwd=_comfirmPwd.text;
        NSInteger num=rePwd.length;
        NSArray* array=[rePwd componentsSeparatedByString:@" "];
        DLog(@"pwd-num:%d，，，，是否包含空格：%d",num,array.count);
        if (num<8|array.count>1) {
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"密码长度必须大于8位并且不能使用空格！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else if (![rePwd isEqualToString:comfirmPwd]){
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"两次密码不一致！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else{
            //TODO:发送修改密码请求
            [_bl resetPwd:user.phone withNewPwd:rePwd];
        }
    }
}
-(void)resetPwdSuccess{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"密码修改成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
-(void)resetPwdFail{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"密码修改失败！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]animated:YES];
}
#pragma mark alert-delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
    [_bl refreshMyself];
}
//md5 32位 加密 （小写）
-(NSString *)md5:(NSString *)str {
    
    
    
    const char *cStr = [str UTF8String];
    
    
    
    unsigned char result[32];
    
    
    
    CC_MD5( cStr, strlen(cStr), result );
    
    
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15]];
    
}

@end
