//
//  ShopCartViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ShopCartViewController.h"

@interface ShopCartViewController ()
@property (strong,nonatomic) NSMutableArray* carts;
@end

@implementation ShopCartViewController

NSMutableDictionary* detail;
- (void)viewDidLoad
{
    [super viewDidLoad];
    detail=[[NSMutableDictionary alloc] init];
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

#pragma mark - custom-method
-(void)caculateDeductionAndTotal{
    CGFloat deducion=0.0;
    CGFloat total=0.0;
    for(int i=0;i<_carts.count;i++){
        NSDictionary* cart=[_carts objectAtIndex:i];
        total+=[[cart objectForKey:@"number"] intValue]*[[cart objectForKey:@"price"] doubleValue];
        deducion+=[[cart objectForKey:@"max_deduction"] doubleValue]*[[cart objectForKey:@"number"] intValue];
    }
    _countNum.text=[NSString stringWithFormat:@"￥%0.2f",total];
    _deductionNum.text=[NSString stringWithFormat:@"￥%0.2f",deducion];
    [detail setValue:[NSString stringWithFormat:@"%0.2f",total] forKey:@"totalPrice"];
    [detail setValue:[NSString stringWithFormat:@"%0.2f",deducion] forKey:@"maxDeduction"];
}


- (IBAction)payTo:(id)sender {
}

- (IBAction)stepperValueChanged:(id)sender {
    UIStepper* stepper=(UIStepper*)sender;
    NSInteger row=[self.tableView indexPathForCell:((UITableViewCell*)[[[sender superview] superview]superview]) ].row;
    NSDictionary* cart=[_carts objectAtIndex:row];
    [ _bl modifyShoppingCartWithShopID:[cart objectForKey:@"shopping_id"] number:[NSString stringWithFormat:@"%d",(int)stepper.value] comment:nil];
    DLog(@"%f+row:%d",stepper.value,row);
}

#pragma mark - TableViewDelegate
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        NSDictionary* cart=[_carts objectAtIndex:indexPath.row];
        [_bl delShoppingCartWithShopID:[cart objectForKey:@"shopping_id"]];
        [_carts removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}
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
    UILabel* sizeColor=(UILabel*)[cell viewWithTag:7];
    NSDictionary* cart=[_carts objectAtIndex:indexPath.row];
    title.text=[cart objectForKey:@"name"];
    price.text=[NSString stringWithFormat:@"￥ %@",[cart objectForKey:@"price"]];
    num.text=[NSString stringWithFormat:@"x %@",[cart objectForKey:@"number"]];
    NSArray* roll=(NSArray*)[cart objectForKey:@"roll_pics" ];
    NSDictionary* dict=[roll objectAtIndex:0];
    NSString* url=[NSString stringWithFormat:PicUrlString,[dict objectForKey:@"pic"]];
    
    [productImg sd_setImageWithURL:[NSURL URLWithString:url ] placeholderImage:[UIImage imageNamed:@"img_nil.png"]];
    stepper.value=[[cart objectForKey:@"number"] doubleValue];
    sizeColor.text=[NSString stringWithFormat:@"%@",[cart objectForKey:@"comment"]];
    
    return cell;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_carts==nil){
        return 0;
    }
    return _carts.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

#pragma mark BLDelegate
-(void)getShopingCartsSuccess:(NSArray *)array{
    if([array isKindOfClass:[NSNull class]]){
        _carts=nil;
        _tableView.hidden=YES;
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, [UIScreen mainScreen].bounds.size.height-108-49)];
        label.font=[UIFont systemFontOfSize:18.0];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"您购物车中还没有商品哦！";
        label.backgroundColor=[UIColor whiteColor];
        label.textColor=[UIColor grayColor];
        
        _payBtn.enabled=false;
        
        [self.view addSubview:label];
    }else{
        _carts=[array mutableCopy];
        [_tableView reloadData];
        [self caculateDeductionAndTotal];
    }
}
-(void)modifyShoppingCartSuccess{
    [_bl getShoppingCarts];
}
-(void)delShoppingCartSuccess{
    [_bl getShoppingCarts];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(_carts==nil){
        // 提示添加购物车成功
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"购物车为空，请添加商品--！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSMutableString* shoppingIDs=[[NSMutableString alloc] init];
    for(int i=0;i<_carts.count;i++){
        NSDictionary* cart=(NSDictionary*)[_carts objectAtIndex:i];
        if(i==0){
            [shoppingIDs appendFormat:@"%@",[cart objectForKey:@"shopping_id"] ];
        }else{
            [shoppingIDs appendFormat:@",%@",(NSString*)[cart objectForKey:@"shopping_id"]];
        }
    }
    DLog(@"shopingIDs=%@",shoppingIDs);
    [detail setValue:shoppingIDs forKey:@"shopping_ids"];
    [detail setValue:_carts forKey:@"carts"];
    ShopCartConfirmTableViewController* dest=(ShopCartConfirmTableViewController*)segue.destinationViewController;
    dest.detail=detail;
}

@end
