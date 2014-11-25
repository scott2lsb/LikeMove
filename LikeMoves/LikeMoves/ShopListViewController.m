//
//  ShopListViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-21.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ShopListViewController.h"
#import "ShopDetailViewController.h"
@interface ShopListViewController ()

@end

@implementation ShopListViewController
NSDictionary* selectProduct;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[LMShopBL new];
    _bl.delegate=self;
    //请求商品列表
    _productTable.delegate=self;
    _productTable.dataSource=self;
    //去掉table多余的线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.productTable setTableFooterView:view];

    Reachability* reach=[Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([reach isReachable]) {
        [_bl getProductsInPromotion];
        //指示框
        _spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor orangeColor]];
        _spinner.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2);
        [self.view addSubview:_spinner];
    }else{
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"网络连接失败，请检查网络！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
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
#pragma mark - tableview-datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if([_products isKindOfClass:[NSNull class]]){
        return 0;
    }
    return _products.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ProductCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: cellIdentifier ];
    }
    //昵称、当天运动时长、当月已运动天数、金币数量
    UIImageView* proImg=(UIImageView*)[cell viewWithTag:1];
    UILabel* title=(UILabel*)[cell viewWithTag:2];
    UILabel* price=(UILabel*)[cell viewWithTag:3];
    UILabel* sold=(UILabel*)[cell viewWithTag:4];
    NSDictionary* product=[_products objectAtIndex:indexPath.row];
    title.text=[product objectForKey:@"name"];
    price.text=[NSString stringWithFormat:@"￥%0.2f",[[product objectForKey:@"price"] floatValue]];
    sold.text=[NSString stringWithFormat:@"销量:%@",[product objectForKey:@"sold_num"]];
    NSString* url;
    NSArray* pics=(NSArray*)[product objectForKey:@"pics"];
    if ([pics isKindOfClass:[NSNull class]]) {
        url=nil;
    }else{
        NSDictionary*dict=(NSDictionary*)[pics objectAtIndex:0];
        url=[NSString stringWithFormat:PicUrlString,[dict objectForKey:@"pic"]];
    }
    [proImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"UMS_email_off"]];
    proImg.layer.cornerRadius=15.0;
    proImg.layer.masksToBounds=YES;

    return cell;
}

#pragma mark - ShopBlDelegate
-(void)getProductInPromotionSuccess:(NSArray *)array{
    [_spinner stopAnimating];
    _products=array;
    [_productTable reloadData];
}
#pragma mark - TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        selectProduct=[_products objectAtIndex:indexPath.row];
    return indexPath;
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{if([segue.destinationViewController isKindOfClass:[ShopDetailViewController class]]){
     UIViewController* view = segue.destinationViewController;
    [view setValue:selectProduct forKey:@"selectProduct"];
 }
}
- (IBAction)pushToShopCart:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ShopCartPage"];
    [self.navigationController pushViewController:tabVC animated:YES];
}
@end
