//
//  ShopListViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-21.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ShopListViewController.h"

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

    
    [_bl getProductsInPromotion];
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
    price.text=[NSString stringWithFormat:@"￥%@",[product objectForKey:@"price"] ];
    sold.text=[NSString stringWithFormat:@"销量:%@",[product objectForKey:@"sold_num"]];
    NSString* url;
    NSArray* pics=(NSArray*)[product objectForKey:@"pics"];
    if ([pics isKindOfClass:[NSNull class]]) {
        url=nil;
    }else{
        NSDictionary*dict=(NSDictionary*)[pics objectAtIndex:0];
        url=[NSString stringWithFormat:@"http://www.haoapp123.com/app/localuser/aidongdong/%@",[dict objectForKey:@"pic"]];
    }
    [proImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"UMS_email_off"]];
    return cell;
}

#pragma mark - ShopBlDelegate
-(void)getProductInPromotionSuccess:(NSArray *)array{
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     UIViewController* view = segue.destinationViewController;
    [view setValue:selectProduct forKey:@"selectProduct"];
 }

@end
