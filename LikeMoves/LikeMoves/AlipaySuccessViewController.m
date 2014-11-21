//
//  AlipaySuccessViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-20.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "AlipaySuccessViewController.h"

@interface AlipaySuccessViewController ()

@end

@implementation AlipaySuccessViewController

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
    NSString* orderInfo=[[NSUserDefaults standardUserDefaults] objectForKey:mUserPayingOrder];
    NSArray* orderInfos=[orderInfo componentsSeparatedByString:@","];
    _realPrice.text=orderInfos[1];
    _orderNO.text=orderInfos[2];
    //订单支付失败
    _failOrderNO.text=orderInfos[2];
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

- (IBAction)payComplete:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainTabPage"];
    [self presentViewController:tabVC animated:YES completion:^(void){
    }];
}

- (IBAction)payFailComplete:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainTabPage"];
    [self presentViewController:tabVC animated:YES completion:^(void){
    }];
}
@end
