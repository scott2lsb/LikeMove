//
//  ResetPwdViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-7.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ResetPwdViewController.h"

@interface ResetPwdViewController ()

@end

@implementation ResetPwdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMUserActBL alloc] init];
    _bl.delegate=self;
    /**
     *  界面元素
     */
    _phone.text=_phoneNum;
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

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)resetPwd:(id)sender {
    if (_resetPwd.text.length<8||_comfirmPwd.text.length<8) {//密码长度最少为8
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:@"密码长度最少为8位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];

    } else if(![_resetPwd.text isEqualToString:_comfirmPwd.text]){//密码两次输入不一致
        //alert

        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:@"两次密码输入不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];

    }else{
        [_bl resetPwd:_phoneNum withNewPwd:_resetPwd.text];
    }
}
#pragma mark - UserDelegate
-(void)resetPwdFail{
    
}
-(void)resetPwdSuccess{
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginPage"];
    [self presentViewController:tabVC animated:YES completion:^(void){
    }];
}
@end
