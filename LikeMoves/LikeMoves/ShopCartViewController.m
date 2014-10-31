//
//  ShopCartViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ShopCartViewController.h"

@interface ShopCartViewController ()
@property (strong,nonatomic) NSArray* carts;
@end

@implementation ShopCartViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMShopBL alloc]init];
    _bl.delegate=self;
    [_bl getShoppingCarts];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    UIView* view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)editCartInfo:(id)sender {
}

- (IBAction)payTo:(id)sender {
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}
#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CartCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: cellIdentifier];
    }

    UIImageView* productImg=(UIImageView*)[cell viewWithTag:1];
    UILabel* title=(UILabel*)[cell viewWithTag:2];
    UILabel* price=(UILabel*)[cell viewWithTag:3];
    UILabel* num=(UILabel*)[cell viewWithTag:4];
    UIStepper* stepper=(UIStepper*)[cell viewWithTag:5];
    NSDictionary* cart=[_carts objectAtIndex:indexPath.section];
    title.text=[cart objectForKey:@"name"];
    price.text=[NSString stringWithFormat:@"￥ %@",[cart objectForKey:@"price"]];
    num.text=[NSString stringWithFormat:@"x %@",[cart objectForKey:@"number"]];
    NSArray* roll=(NSArray*)[cart objectForKey:@"roll_pics" ];
    NSDictionary* dict=[roll objectAtIndex:0];
    NSString* url=[NSString stringWithFormat:PicUrlString,[dict objectForKey:@"pic"]];
    [productImg sd_setImageWithURL:[NSURL URLWithString:url ] placeholderImage:[UIImage imageNamed:@"testuser3.png"]];
    stepper.value=[[cart objectForKey:@"number"] doubleValue];
        return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _carts.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark BLDelegate
-(void)getShopingCartsSuccess:(NSArray *)array{
    _carts=array;
    [_tableView reloadData];
}

@end
